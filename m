Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6EE751BDFB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 13:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355021AbiEELbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 07:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiEELbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 07:31:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF764AE19;
        Thu,  5 May 2022 04:27:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5847361BB6;
        Thu,  5 May 2022 11:27:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4EF9C385A4;
        Thu,  5 May 2022 11:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651750042;
        bh=fnNI5C558oOhnx11/zpZ9dGyJmeljeFfP9Tjkcnh56A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Se58sKjMCaroYzvmi+GwU3ni6/Vv1rNomhlwS1J3u+cnz75TbqC5zHSx+EysQIqgF
         A66AUKykh2wtbdW+NwA+Qu02wxeaJ4h3h8hD3F95w6zUVOxo3H7Ro4LOPXH6X/jTsU
         MB+Re/UaxLzI7DkzQuyqv8tmvF8VAf9T0dHFpQ6pahr9a6j8KkRad8ZmvEOcJlrOVW
         2wWSYdqCozcV6/ptJd5oTzvVxx4bURpFy/EhThFhTwjfxALH/Tt0qt8YjmW/xYw70R
         WpBPTt4Ec7OgQYTtNqsGus2S+UB0cg7NqCYqv4nt33OMhOk+In0i93kAzalRKcYFrZ
         ENIEbb02gH6yQ==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nmZdg-009Bfm-37; Thu, 05 May 2022 12:27:20 +0100
MIME-Version: 1.0
Date:   Thu, 05 May 2022 12:27:19 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christoffer Dall <cdall@cs.columbia.edu>,
        Oliver Upton <oupton@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kvm-arm tree
In-Reply-To: <20220505201156.65decdc8@canb.auug.org.au>
References: <20220505201005.7ab164c0@canb.auug.org.au>
 <20220505201156.65decdc8@canb.auug.org.au>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <fb9f82ae7d3a37356fe16ca41285cc1d@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: sfr@canb.auug.org.au, cdall@cs.columbia.edu, oupton@google.com, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-05 11:11, Stephen Rothwell wrote:
> Hi all,
> 
> On Thu, 5 May 2022 20:10:05 +1000 Stephen Rothwell 
> <sfr@canb.auug.org.au> wrote:
>> 
>> After merging the kvm-arm tree, today's linux-next build (htmldocs)
>> failed like this:
>> 
>> Sphinx parallel build error:
>> docutils.utils.SystemMessage: 
>> /home/sfr/next/next/Documentation/virt/kvm/api.rst:6175: (SEVERE/4) 
>> Title level inconsistent:
>> 
>> For arm/arm64:
>> ^^^^^^^^^^^^^^
>> 
>> Caused by commit
>> 
>>   bfbab4456877 ("KVM: arm64: Implement PSCI SYSTEM_SUSPEND")
>> 
>> I have applied the following patch for today (I don't  know if it is
>> correct, but it does build).
> 
> oops :-)
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 5 May 2022 20:06:34 +1000
> Subject: [PATCH] fix up for "VM: arm64: Implement PSCI SYSTEM_SUSPEND"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  Documentation/virt/kvm/api.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst 
> b/Documentation/virt/kvm/api.rst
> index deeb95dabc64..e5d685d4de11 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6173,7 +6173,7 @@ Valid values for 'type' are:
>     the VM.
> 
>  For arm/arm64:
> -^^^^^^^^^^^^^^
> +--------------
> 
>     KVM_SYSTEM_EVENT_SUSPEND exits are enabled with the
>     KVM_CAP_ARM_SYSTEM_SUSPEND VM capability. If a guest invokes the 
> PSCI
> --
> 2.35.1

Thanks, I've taken this patch in my branch.

         M.
-- 
Jazz is not dead. It just smells funny...
