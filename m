Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE7256888A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbiGFMnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiGFMnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:43:46 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [5.144.164.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE351F610
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 05:43:45 -0700 (PDT)
Received: from [192.168.1.101] (abxi46.neoplus.adsl.tpnet.pl [83.9.2.46])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 28DEB3F7A6;
        Wed,  6 Jul 2022 14:43:44 +0200 (CEST)
Message-ID: <3c6d6d13-0612-e808-d14c-81f9b312664a@somainline.org>
Date:   Wed, 6 Jul 2022 14:43:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [V3 7/7] remoteproc: sysmon: Send sysmon state only for running
 rprocs
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>, bjorn.andersson@linaro.org
Cc:     agross@kernel.org, mathieu.poirier@linaro.org,
        dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Siddharth Gupta <sidgup@codeaurora.org>
References: <1657022900-2049-1-git-send-email-quic_sibis@quicinc.com>
 <1657022900-2049-8-git-send-email-quic_sibis@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <1657022900-2049-8-git-send-email-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.07.2022 14:08, Sibi Sankar wrote:
> From: Siddharth Gupta <sidgup@codeaurora.org>
> 
> When a new remoteproc boots up, send the sysmon state notification
> of only running remoteprocs. Sending state of remoteprocs booting
> up in parallel can cause a race between SSR clients of the remoteproc
> that is booting up and the sysmon notification for the same remoteproc,
> resulting in an inconsistency between which state the remoteproc that
> is booting up in parallel.
> 
> For example - if remoteproc A and B crash one after the other, after
> remoteproc A boots up, if the remoteproc A tries to get the state of
> remoteproc B before the sysmon subdevice for B is invoked but after
> the ssr subdevice of B has been invoked, clients on remoteproc A
> might get confused when the sysmon notification indicates a different
> state.
> 
> Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
>  drivers/remoteproc/qcom_sysmon.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_sysmon.c b/drivers/remoteproc/qcom_sysmon.c
> index a9f04dd83ab6..57dde2a69b9d 100644
> --- a/drivers/remoteproc/qcom_sysmon.c
> +++ b/drivers/remoteproc/qcom_sysmon.c
> @@ -512,10 +512,12 @@ static int sysmon_start(struct rproc_subdev *subdev)
>  
>  	mutex_lock(&sysmon_lock);
>  	list_for_each_entry(target, &sysmon_list, node) {
> -		if (target == sysmon)
> +		mutex_lock(&target->state_lock);
> +		if (target == sysmon || target->state != SSCTL_SSR_EVENT_AFTER_POWERUP) {
> +			mutex_unlock(&target->state_lock);
>  			continue;
> +		}
>  
> -		mutex_lock(&target->state_lock);
>  		event.subsys_name = target->name;
>  		event.ssr_event = target->state;
>  
