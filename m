Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D90558B870
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 23:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbiHFV2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 17:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbiHFV2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 17:28:44 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3742F5A8
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 14:28:41 -0700 (PDT)
Date:   Sat, 06 Aug 2022 21:28:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1659821319; x=1660080519;
        bh=3t+gm/btLHdYkkZ3NYKAbKt5z6sF6HBJyqJOtSUuQ1s=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=ZDLi9yFLqFvPl8PXPH6W+mA7LQJriDtwjhXbPycmo6Z7qDf3glJxf5Y0bQSGsM+ai
         EjqAqQGqzewMZ3DawEPtRqCOBesJmxc83bP2ftBsX8264xcac5LDHI9pRS0OSeeyw8
         eLe32FYpgQzfxQcG+eSwutmgHgVWA5LWNWEOA2/4=
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Reply-To: Caleb Connolly <caleb@connolly.tech>
Subject: Re: [PATCH] soc: qcom: rpmhpd: Use highest corner until sync_state
Message-ID: <151c8978-1fa8-6b21-8544-baf5abb45241@connolly.tech>
In-Reply-To: <20220806155035.968340-1-bjorn.andersson@linaro.org>
References: <20220806155035.968340-1-bjorn.andersson@linaro.org>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/08/2022 16:50, Bjorn Andersson wrote:
> In some cases the hardware that the bootloader has left configured
> depends on RPMH power domains for their operation up until the point
> where the related Linux device driver probes and can inherit that
> configuration, or power down the hardware gracefully.
>
> Unfortunately as Linux probes the releavant drivers in sequence there
> are periods during the Linux boot flow where either the genpd refcount
> will reach 0, or worse where the active performance_state votes does not
> meet the requirements of the state that the hardware was left in.
>
> One specific example of this is during boot of e.g. SM8150/SC8180X,
> where the display clock controller probes, without any particular
> performance state needs (to access its registers). This will drop the
> MMCX rail to MIN_SVS, which isn't sufficient to sustain the clock rates
> that the later probing MDP is configured to. This results in an
> unrecoverable system state.
Hi Bjorn,

Seems like my sm8150 device dies before getting this far, bah!

>
> Handle both these cases by keeping the RPMH power-domais that are
> referenced voted for highest state, until sync_state indicates that all
> devices referencing the RPMH power-domain driver has been probed.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Caleb Connolly <caleb@connolly.tech>
> ---
>   drivers/soc/qcom/rpmhpd.c | 35 ++++++++++++++++++++++++++++++++++-
>   1 file changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
> index 092f6ab09acf..494bb6c75ed7 100644
> --- a/drivers/soc/qcom/rpmhpd.c
> +++ b/drivers/soc/qcom/rpmhpd.c
> @@ -39,6 +39,7 @@
>    * @res_name:=09=09Resource name used for cmd-db lookup
>    * @addr:=09=09Resource address as looped up using resource name from
>    *=09=09=09cmd-db
> + * @state_synced:       Indicator that sync_state has been invoked for t=
he rpmhpd resource
>    */
>   struct rpmhpd {
>   =09struct device=09*dev;
> @@ -54,6 +55,7 @@ struct rpmhpd {
>   =09bool=09=09enabled;
>   =09const char=09*res_name;
>   =09u32=09=09addr;
> +=09bool=09=09state_synced;
>   };
>
>   struct rpmhpd_desc {
> @@ -493,7 +495,13 @@ static int rpmhpd_aggregate_corner(struct rpmhpd *pd=
, unsigned int corner)
>   =09unsigned int this_active_corner =3D 0, this_sleep_corner =3D 0;
>   =09unsigned int peer_active_corner =3D 0, peer_sleep_corner =3D 0;
>
> -=09to_active_sleep(pd, corner, &this_active_corner, &this_sleep_corner);
> +=09if (pd->state_synced) {
> +=09=09to_active_sleep(pd, corner, &this_active_corner, &this_sleep_corne=
r);
> +=09} else {
> +=09=09/* Clamp to highest corner if sync_state hasn't happened */
> +=09=09this_active_corner =3D pd->level_count - 1;
> +=09=09this_sleep_corner =3D pd->level_count - 1;
> +=09}
>
>   =09if (peer && peer->enabled)
>   =09=09to_active_sleep(peer, peer->corner, &peer_active_corner,
> @@ -708,11 +716,36 @@ static int rpmhpd_probe(struct platform_device *pde=
v)
>   =09return of_genpd_add_provider_onecell(pdev->dev.of_node, data);
>   }
>
> +static void rpmhpd_sync_state(struct device *dev)
> +{
> +=09const struct rpmhpd_desc *desc =3D of_device_get_match_data(dev);
> +=09struct rpmhpd **rpmhpds =3D desc->rpmhpds;
> +=09unsigned int corner;
> +=09struct rpmhpd *pd;
> +=09unsigned int i;
> +
> +=09mutex_lock(&rpmhpd_lock);
> +=09for (i =3D 0; i < desc->num_pds; i++) {
> +=09=09pd =3D rpmhpds[i];
> +=09=09if (!pd)
> +=09=09=09continue;
> +
> +=09=09pd->state_synced =3D true;
> +=09=09if (pd->enabled)
> +=09=09=09corner =3D max(pd->corner, pd->enable_corner);
> +=09=09else
> +=09=09=09corner =3D 0;
> +=09=09rpmhpd_aggregate_corner(pd, corner);
> +=09}
> +=09mutex_unlock(&rpmhpd_lock);
> +}
> +
>   static struct platform_driver rpmhpd_driver =3D {
>   =09.driver =3D {
>   =09=09.name =3D "qcom-rpmhpd",
>   =09=09.of_match_table =3D rpmhpd_match_table,
>   =09=09.suppress_bind_attrs =3D true,
> +=09=09.sync_state =3D rpmhpd_sync_state,
>   =09},
>   =09.probe =3D rpmhpd_probe,
>   };
> --
> 2.35.1
>

--
Kind Regards,
Caleb

