Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CD64EC968
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348666AbiC3QPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348201AbiC3QPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:15:13 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90237AE6D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:13:25 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id d30so4068292pjk.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=M/Zoar5SSp1EsMP8iHI71jE4Bd441XHopIDF3wpbTfY=;
        b=qMux20Kc25sqN7xL6UbJubscfJ+vC0l3I50pFZNyq/Dj/Lh0oonjEDQcpIX1AsPfO9
         l9AEjhTkNGqSULrSveCx6D/oebLCIZ2JYtlKugaOKZ2yZIxxvMRkiSiRoaVlJcK7x4v5
         LL5YsQl6DSylAwjZisELmA/Pcs+BNqP6K5rdrjc/eRkBNYtj7lAqiR28ugGZ/VrWGx5S
         M0jUvoK5XdOj104DOsebwYSNkfUTbHbFQ9FrqFy6qOizNBmOjYoOFUb6rK6bPpvKhgIJ
         R0ms0E24a2T4DEtb0FLPl7TaTqHOZNR4aDLMdIgFba8zF7qSM98u6Ygvt9sIT9rJrvy+
         FqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M/Zoar5SSp1EsMP8iHI71jE4Bd441XHopIDF3wpbTfY=;
        b=v6VpOPVE3K40BXVVYlV9HSW+vhj6rJvhXm/AzuSHh130+Oxg3h/yxdzItM2v6Ljdas
         orAMklo/C3w9iTKqw4WHCLIAKOj1xJw4Z5ubCmt3PJ3Dy7lrbs8IsByiU4OtMC5IBiOH
         qvZqAv895XuUWodPhvcLGuhiGHGwey6lg/LrCc5uRZJzyk0baMy2IwRnhDj1hovmZNPc
         I13bR7dgotKi1+2mTnd0mmZ3R2ZMO93CWO3q+MJ6Sy4jcfpM0b5BlWmt823S5JX0kZM3
         khCI/hNUj6fIAdq+X7wk+fSKTXVoiTyYNOrM3gbJVfqdJYulr9rfvVjmIEvSJzre5VV8
         jAmw==
X-Gm-Message-State: AOAM530sfG5Gw0MBCyILA2ngkqjQRNZboOyDOa8jMdenRTMQY10gwbDt
        akTxXF28Gvw1bxhvF7PTMRI+GA==
X-Google-Smtp-Source: ABdhPJwVhFbLalbo/diRBofUrSg2cJbTuSP+bItPvIL4oe3IFuRyggKDpJSO8eSCiYc1OscLOnef3g==
X-Received: by 2002:a17:903:2285:b0:154:7dd3:c949 with SMTP id b5-20020a170903228500b001547dd3c949mr61236plh.108.1648656805022;
        Wed, 30 Mar 2022 09:13:25 -0700 (PDT)
Received: from [192.168.0.2] ([50.53.169.105])
        by smtp.gmail.com with ESMTPSA id h13-20020a056a00230d00b004f427ffd485sm26850187pfh.143.2022.03.30.09.13.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 09:13:24 -0700 (PDT)
Message-ID: <b201a3ed-5698-4e91-adc9-34c938e43668@pensando.io>
Date:   Wed, 30 Mar 2022 09:13:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH net] ixgbe: ensure IPsec VF<->PF compatibility
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        intel-wired-lan@lists.osuosl.org,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Raed Salem <raeds@nvidia.com>,
        Shannon Nelson <shannon.nelson@oracle.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Steffen Klassert <steffen.klassert@secunet.com>
References: <3702fad8a016170947da5f3c521a9251cf0f4a22.1648637865.git.leonro@nvidia.com>
From:   Shannon Nelson <snelson@pensando.io>
In-Reply-To: <3702fad8a016170947da5f3c521a9251cf0f4a22.1648637865.git.leonro@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/22 4:01 AM, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
>
> The VF driver can forward any IPsec flags and such makes the function
> is not extendable and prone to backward/forward incompatibility.
>
> If new software runs on VF, it won't know that PF configured something
> completely different as it "knows" only XFRM_OFFLOAD_INBOUND flag.
>
> Fixes: eda0333ac293 ("ixgbe: add VF IPsec management")
> Reviewed-by: Raed Salem <raeds@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> There is no simple fix for this VF/PF incompatibility as long as FW
> doesn't filter/decline unsupported options when convey mailbox from VF
> to PF.
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> index e596e1a9fc75..236f244e3f65 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> @@ -903,7 +903,9 @@ int ixgbe_ipsec_vf_add_sa(struct ixgbe_adapter *adapter, u32 *msgbuf, u32 vf)
>   	/* Tx IPsec offload doesn't seem to work on this
>   	 * device, so block these requests for now.
>   	 */
> -	if (!(sam->flags & XFRM_OFFLOAD_INBOUND)) {
> +	sam->flags = sam->flags & ~XFRM_OFFLOAD_IPV6;
> +	if (!(sam->flags & XFRM_OFFLOAD_INBOUND) ||
> +	    sam->flags & ~XFRM_OFFLOAD_INBOUND) {

So after stripping the IPV6 flag, you're checking to be sure that 
INBOUND is the only flag enabled, right?
Could you use
     if (sam->flags != XFRM_OFFLOAD_INBOUND) {
instead?

sln

>   		err = -EOPNOTSUPP;
>   		goto err_out;
>   	}

