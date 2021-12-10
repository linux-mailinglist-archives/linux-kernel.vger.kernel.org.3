Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422CC46FE44
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 10:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239736AbhLJKAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 05:00:37 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:48668 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbhLJKAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 05:00:36 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2988A210E7;
        Fri, 10 Dec 2021 09:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639130221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wyi1tTJVsj009ESy/KKw4c45LiGOomX2n/IstoHHMeU=;
        b=IJl2zf2baESea6sQAzSAfVfsNRb22XUgqgE5cwSmk9/4iufaqmZHABT6LUi+AwcR1XwpUB
        M3Qln15tp6TRNB8+MZTSDQ7zf6EpltFoGqveycYyNanXhkHsubvvVTw5U5HwMIXnb9hB2P
        nL/orM9yFxuvyos6S0iZ8YV1qO7o1J8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639130221;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wyi1tTJVsj009ESy/KKw4c45LiGOomX2n/IstoHHMeU=;
        b=kYOvDFIzNQ8xrH5hrFhnbBL4Tb1/pCs9SCOxmRXWzZR5FFMM1phGNhnitG2iaAjaTlqW4u
        +9I0u4vYfhpVmOAA==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D8507A3B85;
        Fri, 10 Dec 2021 09:57:00 +0000 (UTC)
Date:   Fri, 10 Dec 2021 10:57:00 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Jerome Marchand <jmarchan@redhat.com>
cc:     Steven Rostedt <rostedt@goodmis.org>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] recordmcount.pl: look for jgnop instruction as well as
 bcrl on s390
In-Reply-To: <20211210093827.1623286-1-jmarchan@redhat.com>
Message-ID: <alpine.LSU.2.21.2112101054070.5704@pobox.suse.cz>
References: <20211210093827.1623286-1-jmarchan@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2021, Jerome Marchand wrote:

> On s390, recordmcount.pl is looking for "bcrl 0,<xxx>" instructions in
> the objdump -d outpout. However since binutils 2.37, objdump -d
> display "jgnop <xxx>" for the same instruction. Update the
> mcount_regex so that it accepts both.
> 
> Signed-off-by: Jerome Marchand <jmarchan@redhat.com>

Yes, we ran into exactly this issue too...

> ---
>  scripts/recordmcount.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
> index 7d631aaa0ae1..52a000b057a5 100755
> --- a/scripts/recordmcount.pl
> +++ b/scripts/recordmcount.pl
> @@ -219,7 +219,7 @@ if ($arch eq "x86_64") {
>  
>  } elsif ($arch eq "s390" && $bits == 64) {
>      if ($cc =~ /-DCC_USING_HOTPATCH/) {
> -	$mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*c0 04 00 00 00 00\\s*brcl\\s*0,[0-9a-f]+ <([^\+]*)>\$";
> +	$mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*c0 04 00 00 00 00\\s*(bcrl\\s*0,|jgnop\\s*)[0-9a-f]+ <([^\+]*)>\$";
>  	$mcount_adjust = 0;
>      }
>      $alignment = 8;

...and we have exactly the same fix in SLES. I haven't got to submit it 
to upstream yet :(, many thanks for doing it.

So at least

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
