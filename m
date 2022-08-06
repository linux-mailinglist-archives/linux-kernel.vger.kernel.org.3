Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B60C58B844
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 22:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbiHFUnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 16:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiHFUnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 16:43:35 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1209FD1;
        Sat,  6 Aug 2022 13:43:33 -0700 (PDT)
Received: from [192.168.1.101] (abxh187.neoplus.adsl.tpnet.pl [83.9.1.187])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id C4A453F713;
        Sat,  6 Aug 2022 22:43:28 +0200 (CEST)
Message-ID: <55e88968-69f6-30f1-048b-6fa6a0c26909@somainline.org>
Date:   Sat, 6 Aug 2022 22:43:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] soc: qcom: rpmhpd: Use highest corner until sync_state
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <20220806155035.968340-1-bjorn.andersson@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220806155035.968340-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6.08.2022 17:50, Bjorn Andersson wrote:
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
> 
> Handle both these cases by keeping the RPMH power-domais that are
> referenced voted for highest state, until sync_state indicates that all
> devices referencing the RPMH power-domain driver has been probed.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
Must have been fun to debug..

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
>  drivers/soc/qcom/rpmhpd.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
> index 092f6ab09acf..494bb6c75ed7 100644
> --- a/drivers/soc/qcom/rpmhpd.c
> +++ b/drivers/soc/qcom/rpmhpd.c
> @@ -39,6 +39,7 @@
>   * @res_name:		Resource name used for cmd-db lookup
>   * @addr:		Resource address as looped up using resource name from
>   *			cmd-db
> + * @state_synced:       Indicator that sync_state has been invoked for the rpmhpd resource
>   */
>  struct rpmhpd {
>  	struct device	*dev;
> @@ -54,6 +55,7 @@ struct rpmhpd {
>  	bool		enabled;
>  	const char	*res_name;
>  	u32		addr;
> +	bool		state_synced;
>  };
>  
>  struct rpmhpd_desc {
> @@ -493,7 +495,13 @@ static int rpmhpd_aggregate_corner(struct rpmhpd *pd, unsigned int corner)
>  	unsigned int this_active_corner = 0, this_sleep_corner = 0;
>  	unsigned int peer_active_corner = 0, peer_sleep_corner = 0;
>  
> -	to_active_sleep(pd, corner, &this_active_corner, &this_sleep_corner);
> +	if (pd->state_synced) {
> +		to_active_sleep(pd, corner, &this_active_corner, &this_sleep_corner);
> +	} else {
> +		/* Clamp to highest corner if sync_state hasn't happened */
> +		this_active_corner = pd->level_count - 1;
> +		this_sleep_corner = pd->level_count - 1;
> +	}
>  
>  	if (peer && peer->enabled)
>  		to_active_sleep(peer, peer->corner, &peer_active_corner,
> @@ -708,11 +716,36 @@ static int rpmhpd_probe(struct platform_device *pdev)
>  	return of_genpd_add_provider_onecell(pdev->dev.of_node, data);
>  }
>  
> +static void rpmhpd_sync_state(struct device *dev)
> +{
> +	const struct rpmhpd_desc *desc = of_device_get_match_data(dev);
> +	struct rpmhpd **rpmhpds = desc->rpmhpds;
> +	unsigned int corner;
> +	struct rpmhpd *pd;
> +	unsigned int i;
> +
> +	mutex_lock(&rpmhpd_lock);
> +	for (i = 0; i < desc->num_pds; i++) {
> +		pd = rpmhpds[i];
> +		if (!pd)
> +			continue;
> +
> +		pd->state_synced = true;
> +		if (pd->enabled)
> +			corner = max(pd->corner, pd->enable_corner);
> +		else
> +			corner = 0;
> +		rpmhpd_aggregate_corner(pd, corner);
> +	}
> +	mutex_unlock(&rpmhpd_lock);
> +}
> +
>  static struct platform_driver rpmhpd_driver = {
>  	.driver = {
>  		.name = "qcom-rpmhpd",
>  		.of_match_table = rpmhpd_match_table,
>  		.suppress_bind_attrs = true,
> +		.sync_state = rpmhpd_sync_state,
>  	},
>  	.probe = rpmhpd_probe,
>  };
