Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956FE4910C3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 20:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242898AbiAQTso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 14:48:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56867 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231558AbiAQTsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 14:48:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642448922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BkaVUVNmac0T4v2e7BWvg4MhOnKAoSjwZB50wYBi6DQ=;
        b=Sf5fNqPiH0axbuhbmQLCLMrhqgBnNQwpL6NCC4Iib8dv2RijKzJGJoRBK1HYQPRvnH4Pgr
        gFfXhpOHA1eIOyrm3oDM3O6WvjmIFbl7U4nZfF40Ny0JzDt5X4iRG1lIGsZ6qLnzIF0x68
        VLj69bOT7LPmr/2vZmh0wIFMZbYYYE4=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-Eg8XKyTnMwGFoA2m1THRVg-1; Mon, 17 Jan 2022 14:48:41 -0500
X-MC-Unique: Eg8XKyTnMwGFoA2m1THRVg-1
Received: by mail-oi1-f199.google.com with SMTP id w133-20020acadf8b000000b002c6c86f4afbso11929238oig.16
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 11:48:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BkaVUVNmac0T4v2e7BWvg4MhOnKAoSjwZB50wYBi6DQ=;
        b=dJ748QuFEHhjiGnXn85d8eOey6gSDpmnFtwDXgV6vWk75wKA4CuqCsPh6tvqXsISjR
         ydIcs5Spor6NKrSphTYGt1nnk2BI71SIXsgLBy1Odgvylk4FU0kUf4I7MclUNO+XKT1M
         SYCsoTbSy6l2xo5f5Y7QVbQddkdF54XWPfp3UMzOYr2J5QIIi0OeGyaN9UohxlvmS+JU
         Jij2QV3vKXw5Scre2f39mZNQ7kgGeFKYAjhtZ44laEEWXmH2MPRLf78VnbB2UnPXxaBr
         xbh4+CKW6AyfZ70qcHnlcMiHs7+5dQkrxIKfiBV9Rsd7zZrXOH6+nRzXdcJFl4Raq/vE
         4NIg==
X-Gm-Message-State: AOAM530hgRyrOaHk517svaLJbFJGksarbCpK5kK6dXGB5sAJGDIZE5G0
        CEbHM+1AhnI0q3nI6Uw/OApajHl8q3rtdDqcfKfe3HRIAk79aLwEzVWSL8eXJEiSxR51QPtVTJ9
        epVlq4azInrDObU21FI2vYgnQ
X-Received: by 2002:a9d:897:: with SMTP id 23mr18352501otf.181.1642448919232;
        Mon, 17 Jan 2022 11:48:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxV6d7S4B42Lhgfebo/Y6hY2zVFUwA8UmdTEWyFiGdwasjV4jDLisPTn31/SlOqLLa6+9JoKg==
X-Received: by 2002:a9d:897:: with SMTP id 23mr18352492otf.181.1642448918957;
        Mon, 17 Jan 2022 11:48:38 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::c])
        by smtp.gmail.com with ESMTPSA id p23sm5960818otp.46.2022.01.17.11.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 11:48:38 -0800 (PST)
Date:   Mon, 17 Jan 2022 11:48:36 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chi-Thanh Hoang <chithanh.hoang@gmail.com>
Subject: Re: Issue using faddr2line on kernel modules
Message-ID: <20220117194836.vj2rxr3wocrtdx7k@treble>
References: <CAPDLWs_iSrbXwfKa6CQ0f6H6GE4U88uRhaFgabRjMmSuSEpsiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPDLWs_iSrbXwfKa6CQ0f6H6GE4U88uRhaFgabRjMmSuSEpsiA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 10:27:14AM +0530, Kaiwan N Billimoria wrote:
> Hi there,
> 
> Am researching using the cool faddr2line script to help debug Oops'es
> from kernel modules..
> I find it works just fine when used against the unstripped vmlinux
> with debug symbols.
> 
> My use case is for a kernel module which Oopses, though. Here's my scenario:
> I built a module on a custom debug kernel (5.10.60) with most debug
> options enabled...
> KASLR is enabled by default as well.
> 
> A test kernel module Oopses on my x86_64 guest running this kernel with:
> RIP: 0010:do_the_work+0x15b/0x174 [oops_tryv2]
> 
> So, i try this:
> 
> $ <...>/linux-5.10.60/scripts/faddr2line ./oops_tryv2.ko do_the_work+0x15b/0x174
> bad symbol size: base: 0x0000000000000000 end: 0x0000000000000000
> $
> 
> (It works fine with addr2line though!).
> Now I think I've traced the faddr2line script's failure to locate
> anything down to this:
> ...
> done < <(${NM} -n $objfile | awk -v fn=$func -v end=$file_end '$3 ==
> fn { found=1; line    =$0; start=$1; next } found == 1 { found=0;
> print line, "0x"$1 } END {if (found == 1) print     line, end; }')
> 
> The nm output is:
> $ nm -n ./oops_tryv2.ko |grep -i do_the_work
> 0000000000000000 t do_the_work
> $
> 
> nm shows the text addr as 0x0; this is obviously incorrect (same 0x0
> with objdump -d on the module).
> Am I missing something? Any suggestions as to what I can try, to get
> faddr2line working?

Hi Kaiwan,

Thanks for reporting this issue.  The module text address of 0x0 is not
necessarily incorrect, as the address is relative the the module, where
all text usually starts at zero.

I was able to recreate this problem using a module which only has a
single function in .text.  Does this fix it?

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 6c6439f69a72..cd6e812b9d06 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -111,21 +111,11 @@ __faddr2line() {
 
 	# Go through each of the object's symbols which match the func name.
 	# In rare cases there might be duplicates.
-	file_end=$(${SIZE} -Ax $objfile | awk '$1 == ".text" {print $2}')
 	while read symbol; do
 		local fields=($symbol)
 		local sym_base=0x${fields[0]}
-		local sym_type=${fields[1]}
-		local sym_end=${fields[3]}
-
-		# calculate the size
-		local sym_size=$(($sym_end - $sym_base))
-		if [[ -z $sym_size ]] || [[ $sym_size -le 0 ]]; then
-			warn "bad symbol size: base: $sym_base end: $sym_end"
-			DONE=1
-			return
-		fi
-		sym_size=0x$(printf %x $sym_size)
+		local sym_size=0x${fields[1]}
+		local sym_type=${fields[2]}
 
 		# calculate the address
 		local addr=$(($sym_base + $offset))
@@ -189,7 +179,7 @@ __faddr2line() {
 
 		DONE=1
 
-	done < <(${NM} -n $objfile | awk -v fn=$func -v end=$file_end '$3 == fn { found=1; line=$0; start=$1; next } found == 1 { found=0; print line, "0x"$1 } END {if (found == 1) print line, end; }')
+	done < <(${NM} -nS $objfile | awk -v fn=$func '$4 == fn')
 }
 
 [[ $# -lt 2 ]] && usage

