Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8134D8C10
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 20:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243686AbiCNTKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 15:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbiCNTKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 15:10:03 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACBB220DD;
        Mon, 14 Mar 2022 12:08:53 -0700 (PDT)
Received: from g550jk.localnet (a246182.upc-a.chello.nl [62.163.246.182])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 9A351C8782;
        Mon, 14 Mar 2022 19:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1647284900; bh=c0PhVAVBuzLcDTY70UAlTT8hnsjR2XvszePUiJZYgww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=q9iVJh8gkxFkAohLgEyZc+3ba0+PrjmFzrQVBcJjj41PiNd24TayjH0AkAFa+f9TV
         csgcW1WP7ywAjPZHfHUbILJy1jKvvI5j3/+ooR3QRvXH94sXVmoMBi/6Zd1S0G0+uB
         Ks70d+RPUgps3DeI4vqcTj67T/UnxA48x+WPEQtE=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/10] rpmsg: smd: allow opening rpm_requests even if already opened
Date:   Mon, 14 Mar 2022 20:08:20 +0100
Message-ID: <2630587.mvXUDI8C0e@g550jk>
In-Reply-To: <20220220201909.445468-6-luca@z3ntu.xyz>
References: <20220220201909.445468-1-luca@z3ntu.xyz> <20220220201909.445468-6-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

any feedback on this patch? It's needed for msm8953 to boot properly.

Regards
Luca

On Sonntag, 20. Februar 2022 21:18:58 CET Luca Weiss wrote:
> On msm8953 the channel seems to be already opened when booting Linux but
> we still need to open it for communication with regulators etc.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Changes in v2:
> - rework original patch, don't drop condition completely but allow force
>   opening rpm_requests channel
> 
>  drivers/rpmsg/qcom_smd.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
> index 540e027f08c4..887e21ca51f2 100644
> --- a/drivers/rpmsg/qcom_smd.c
> +++ b/drivers/rpmsg/qcom_smd.c
> @@ -1288,9 +1288,14 @@ static void qcom_channel_state_worker(struct
> work_struct *work) if (channel->state != SMD_CHANNEL_CLOSED)
>  			continue;
> 
> +		/*
> +		 * Always open rpm_requests, even when already opened 
which is
> +		 * required on some SoCs like msm8953.
> +		 */
>  		remote_state = GET_RX_CHANNEL_INFO(channel, state);
>  		if (remote_state != SMD_CHANNEL_OPENING &&
> -		    remote_state != SMD_CHANNEL_OPENED)
> +		    remote_state != SMD_CHANNEL_OPENED &&
> +		    strcmp(channel->name, "rpm_requests"))
>  			continue;
> 
>  		if (channel->registered)




