Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D1B582204
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 10:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiG0IZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 04:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiG0IZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 04:25:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99195CE6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 01:25:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 49C4533A59;
        Wed, 27 Jul 2022 08:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658910307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XYY/x95BQTCo7p5nmA5GQqvRLO4/w9jXUvzdB079WhA=;
        b=z1SP2ty4T+GuZ1veAEfpCA/MrwMxYYUX9dzhBS5a5wJIDVJ1UetGZwtDWQnSNfdFIarGW/
        xttJY/gunADg/GmMDXmFEhAJXvshqEPN3SF8Y3vxweuFNZCIIypYgs4Trb7c1WkML7vS+s
        bt3d1HEtGArT3qE6hzWyYjnTfCYWijw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658910307;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XYY/x95BQTCo7p5nmA5GQqvRLO4/w9jXUvzdB079WhA=;
        b=X0vNs04kTQBcvt7tTsUP5VRmh9fg7cb+h4k+i0iV5sr+XbpP189ylzeOF3v7MTt3KLvhKp
        X69b3tS9aVWTqmAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 23F5D13A8E;
        Wed, 27 Jul 2022 08:25:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ypY4B2P24GJJLQAAMHmgww
        (envelope-from <jdelvare@suse.de>); Wed, 27 Jul 2022 08:25:07 +0000
Date:   Wed, 27 Jul 2022 10:25:04 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] firmware: dmi: Don't take garbage into
 consideration in dmi_smbios3_present()
Message-ID: <20220727102504.6bbefcf9@endymion.delvare>
In-Reply-To: <20220726094329.1725-1-andriy.shevchenko@linux.intel.com>
References: <20220726094329.1725-1-andriy.shevchenko@linux.intel.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, 26 Jul 2022 12:43:29 +0300, Andy Shevchenko wrote:
> The byte at offset 6 represent length. Don't take it and drop it immediately
> by using proper accessor, i.e. get_unaligned_be24().

The subject sounds like you are fixing a bug, while this is only, at
best, a minor optimization.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/firmware/dmi_scan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
> index b2ea318a10a4..24537ce29bc4 100644
> --- a/drivers/firmware/dmi_scan.c
> +++ b/drivers/firmware/dmi_scan.c
> @@ -630,7 +630,7 @@ static int __init dmi_smbios3_present(const u8 *buf)
>  {
>  	if (memcmp(buf, "_SM3_", 5) == 0 &&
>  	    buf[6] < 32 && dmi_checksum(buf, buf[6])) {
> -		dmi_ver = get_unaligned_be32(buf + 6) & 0xFFFFFF;
> +		dmi_ver = get_unaligned_be24(buf + 7);
>  		dmi_num = 0;			/* No longer specified */
>  		dmi_len = get_unaligned_le32(buf + 12);
>  		dmi_base = get_unaligned_le64(buf + 16);

I admit I did not know about get_unaligned_be24(). While I agree that
it makes the source code look better, one downside is that it actually
increases the binary size on x86_64. The reason is that
get_unaligned_be32() is optimized by assembly instruction bswapl, while
get_unaligned_be24() is not. Situation appears to be the same on ia64
and arm. Only arm64 would apparently benefit from your proposed
change.

I'm not too sure what is preferred in such situations.

-- 
Jean Delvare
SUSE L3 Support
