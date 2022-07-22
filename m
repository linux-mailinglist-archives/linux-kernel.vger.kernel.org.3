Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E6757E83E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 22:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236814AbiGVUUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 16:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236214AbiGVUUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 16:20:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74DBF31918
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 13:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658521245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H1askPVuIjPbZ/EEmpk/k7Fpq9HEtgzmyzToUW1b4UE=;
        b=EWNYDRF4Twm1/CsvqDbHwiltaLQnC8cePYLXyB0pqBSQg6+WcQ5TEsoSy4s2eT7zLQn9BI
        zgPMPH9DH7CCFzQ3uK6pQ+HLmFn6XtTR29VWXLR1CQXpmJJULUcX11McQxDI52k760YjIH
        hw80h3CjK9boe7GfIDHpC5BuBqZOwmg=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-156-npxW2uXXOq-WsamPrh5I9w-1; Fri, 22 Jul 2022 16:20:36 -0400
X-MC-Unique: npxW2uXXOq-WsamPrh5I9w-1
Received: by mail-io1-f71.google.com with SMTP id z11-20020a05660217cb00b0067c63cf0236so1931542iox.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 13:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H1askPVuIjPbZ/EEmpk/k7Fpq9HEtgzmyzToUW1b4UE=;
        b=BfitB45q9BOSxTd0ab0O/E2AYlG1uJ0Lfak02CnCoqZMljrvndaLKdr2fZ7cXH02e+
         ciHv7KdJZlcCHy1VoBfh0GNwFYbrHtioWSbm95D0jc3rXLkooszdZV1dUs4Jk/3bmLjB
         7Mf8H1jpVk2CSMdmtTn6dvBjAYrYkvEYuda4R2GbsFBXC0+2/oBW6KA3onDzkL8Vn9XE
         8YgvvcAze4Obb2kWydQ/FFuLeqDI8duiMoDlmi/ubB29U8fTzGvDh1PKrX4rSNpqGM4f
         rkrRnPoTyykMUGFM+nlfWKmTUOxAPRkeZJxNWsFyyfMGvZt1szh02YlksANvQgaBO0xL
         ZrhQ==
X-Gm-Message-State: AJIora9B2ULYTytN/HzTKVNU5m50xMkQCKs6E6EV9wHFgY+lsp3FWyZZ
        Dx65Gs+VPIGdTPA7A50yvkwcmfQy4sbSD6oueiFldZYIlkAhO4V23aVl4F7/nDtD+iv8yrTWhvq
        0/WqFOPpLlpyDNbTTikTV+y25
X-Received: by 2002:a05:6602:379b:b0:67c:70d6:614c with SMTP id be27-20020a056602379b00b0067c70d6614cmr524449iob.2.1658521235463;
        Fri, 22 Jul 2022 13:20:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s/HKPmV8e/aqgMYfZNsaxwLTAnGZ2Lsayz8+R5S9SbY2S+qKAt4tUx28m1ulwuWZ0NJKu0Ug==
X-Received: by 2002:a05:6602:379b:b0:67c:70d6:614c with SMTP id be27-20020a056602379b00b0067c70d6614cmr524444iob.2.1658521235260;
        Fri, 22 Jul 2022 13:20:35 -0700 (PDT)
Received: from [10.0.0.146] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id v3-20020a056e020f8300b002dd0926ee02sm2070930ilo.34.2022.07.22.13.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 13:20:34 -0700 (PDT)
Message-ID: <c0cc00bd-9904-9ede-26b2-66737acffaf2@redhat.com>
Date:   Fri, 22 Jul 2022 15:20:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] xfs: Fix comment typo
Content-Language: en-US
To:     Xin Gao <gaoxin@cdjrlc.com>, djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220722194328.18365-1-gaoxin@cdjrlc.com>
From:   Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20220722194328.18365-1-gaoxin@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/22 2:43 PM, Xin Gao wrote:
> The double `that' is duplicated in line 575, remove one.
> 
> Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
> ---
>  fs/xfs/xfs_trans.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
> index 82cf0189c0db..d055b0938eb9 100644
> --- a/fs/xfs/xfs_trans.c
> +++ b/fs/xfs/xfs_trans.c
> @@ -572,7 +572,7 @@ xfs_trans_apply_sb_deltas(
>   * xfs_trans_unreserve_and_mod_sb() is called to release unused reservations and
>   * apply superblock counter changes to the in-core superblock.  The
>   * t_res_fdblocks_delta and t_res_frextents_delta fields are explicitly NOT
> - * applied to the in-core superblock.  The idea is that that has already been
> + * applied to the in-core superblock.  The idea is that has already been
>   * done.
>   *
>   * If we are not logging superblock counters, then the inode allocated/free and

NAK

The comment is correct

