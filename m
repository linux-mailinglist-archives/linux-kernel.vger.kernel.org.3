Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B234943E9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 00:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344597AbiASXnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 18:43:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25359 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344567AbiASXnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 18:43:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642635789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qcTt5kGemYKdl5NHHgbm78aYoqfuFslMpyzSj05wWe4=;
        b=FxTJKuvkRqMMCq4tBtr4nB7cv33KE69JiNC/3mQG+r8Sve3ZWmWmC7JsnRa4Fu6BRkMRKw
        2O3dZmNN/G4NJG9CqP8XuLdvaIADmozABMh82XxrZ7Hg2Pr17D1aqSTEQpT47j7Gp7Ws28
        pzQ54CgmCni1RZQfxXrV4lk/e9N2Bmk=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-577-jqDkL5xdMFWmWPBkuVOpSg-1; Wed, 19 Jan 2022 18:43:08 -0500
X-MC-Unique: jqDkL5xdMFWmWPBkuVOpSg-1
Received: by mail-ot1-f69.google.com with SMTP id f12-20020a9d5e8c000000b005907d2f83d0so2498736otl.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 15:43:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qcTt5kGemYKdl5NHHgbm78aYoqfuFslMpyzSj05wWe4=;
        b=byOhpKWmZbYn9b8tjwUB2RE2SGDWBhxo9HBbLt906+bhcvGwEvs2+j8m+Eyw6qEvOn
         qdo0Y9o5R56jkF5PQwUNHTZZatbSN9+ZmfX22DHQnDNaJvJaN2Y2JeYM0oNXliXoPKd6
         LCRMZ5f+x00+0AJPhTfRciZCw1SKdun2nqbqIS9XNYWbN/YLZN3j7Nq4UmaZcDRqLpKl
         Hx18qMCpm7ee+kNi2QwpbAR6YcMOmO3Oe5T/N0fNFdhKaCAHPBoQbODi8F5jF8BdHkSg
         jgy1v2Al/LN1/MwLD4BcpI1h/bD6goyMq/Mb+WifX6iZ9dGVOMjlNdQcEyWe14d9yANz
         d3Kg==
X-Gm-Message-State: AOAM530du7EtsWv2yr1g2XQU5Ae92MKDiwyHA4gmhaCDUWhSKFGIpR3w
        NAD0cAxP1i5BMF+rQ17lPB+dS7SzVIbb5fZUlpBKbrpPHLnC34BlJL3hkQ5ajdBWY+Fq52Y/oFu
        jXUtRb0kt6gJezs6S7+B4FnB6
X-Received: by 2002:aca:1311:: with SMTP id e17mr5376386oii.30.1642635786081;
        Wed, 19 Jan 2022 15:43:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxLmMK+K8rmtAuPb4cNun1UAw0cAC14LlR7gXQBNWbYuApI3UJPyN+FbQwm2fa2ymShPD6kkw==
X-Received: by 2002:aca:1311:: with SMTP id e17mr5376374oii.30.1642635785796;
        Wed, 19 Jan 2022 15:43:05 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::c])
        by smtp.gmail.com with ESMTPSA id n22sm530091ooq.27.2022.01.19.15.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 15:43:05 -0800 (PST)
Date:   Wed, 19 Jan 2022 15:43:03 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chi-Thanh Hoang <chithanh.hoang@gmail.com>
Subject: Re: Issue using faddr2line on kernel modules
Message-ID: <20220119234303.tmebbcrg2vpnri4s@treble>
References: <CAPDLWs_iSrbXwfKa6CQ0f6H6GE4U88uRhaFgabRjMmSuSEpsiA@mail.gmail.com>
 <20220117194836.vj2rxr3wocrtdx7k@treble>
 <20220117202751.bmwvfsnqxokob6d2@treble>
 <CAPDLWs-yX4FNrmnF3rHrEoHNktcw2Yi8X6qidss-qKpdw=r4RQ@mail.gmail.com>
 <20220118175239.lqxi2ycgeusk5pxl@treble>
 <CAPDLWs_mirot76g==TPRZDsB6Qn99kxw2N5V=PaDYqBLf=ZSCQ@mail.gmail.com>
 <20220119212126.aydgx62abbngumwy@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220119212126.aydgx62abbngumwy@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 01:21:29PM -0800, Josh Poimboeuf wrote:
> > $ nm -n ./oops_tryv2.ko |grep -C5 do_the_work
> > 0000000000000000 r __func__.24215
> > 0000000000000000 r __param_bug_in_workq
> > 0000000000000000 D __this_module
> > 0000000000000000 r _note_7
> > 0000000000000000 T cleanup_module
> > 0000000000000000 t do_the_work
> > 0000000000000000 t do_the_work.cold
> > 0000000000000000 b gctx
> > 0000000000000000 T init_module
> > 0000000000000000 t try_oops_exit
> > 0000000000000000 t try_oops_init
> > 0000000000000008 b t1
> > $
> > 
> > BTW, here's the code:
> > https://github.com/PacktPublishing/Linux-Kernel-Debugging/tree/main/ch7/oops_tryv2
> 
> Ok, it looks like the symbols aren't sorted like the code expects.  I
> need to do a more robust fix.

Ok, please try this instead.  This takes a much more robust approach to
the function size calculation, using readelf to confine the symbol
search to the section matching the original symbol.

This actually has multiple fixes and cleanups, so it'll eventually be
split up into a patch set.

----

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 6c6439f69a72..1acb68927977 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -97,10 +97,11 @@ __faddr2line() {
 	local dir_prefix=$3
 	local print_warnings=$4
 
+	local first=1
 	local func=${func_addr%+*}
 	local offset=${func_addr#*+}
 	offset=${offset%/*}
-	local size=
+	local user_size=
 	[[ $func_addr =~ "/" ]] && size=${func_addr#*/}
 
 	if [[ -z $func ]] || [[ -z $offset ]] || [[ $func = $func_addr ]]; then
@@ -110,73 +111,87 @@ __faddr2line() {
 	fi
 
 	# Go through each of the object's symbols which match the func name.
-	# In rare cases there might be duplicates.
-	file_end=$(${SIZE} -Ax $objfile | awk '$1 == ".text" {print $2}')
+	# In rare cases there might be duplicates, in which case we print both.
 	while read symbol; do
 		local fields=($symbol)
-		local sym_base=0x${fields[0]}
-		local sym_type=${fields[1]}
-		local sym_end=${fields[3]}
-
-		# calculate the size
-		local sym_size=$(($sym_end - $sym_base))
-		if [[ -z $sym_size ]] || [[ $sym_size -le 0 ]]; then
-			warn "bad symbol size: base: $sym_base end: $sym_end"
+		local sym_addr=0x${fields[1]}
+		local sym_size=${fields[2]}
+		local sym_sec=${fields[6]}
+
+		# Get the section size:
+		local sec_size=$(${READELF} --section-headers --wide $objfile |
+			sed 's/\[ /\[/' |
+			awk -v sec=$sym_sec '$1 == "[" sec "]" { print "0x" $6; exit }')
+
+		if [[ -z $sec_size ]]; then
+			warn "bad section size: section: $sym_sec"
 			DONE=1
 			return
 		fi
-		sym_size=0x$(printf %x $sym_size)
 
-		# calculate the address
-		local addr=$(($sym_base + $offset))
-		if [[ -z $addr ]] || [[ $addr = 0 ]]; then
-			warn "bad address: $sym_base + $offset"
+		# Calculate the symbol size:
+		#
+		# We can't use the ELF size, because kallsyms also includes the
+		# padding bytes in its size calculation.  For kallsyms, the
+		# size calculation is the distance between the symbol and the
+		# next symbol in a sorted list.
+		local size=$(${READELF} --symbols --wide $objfile |
+			awk -v sec=$sym_sec '$7 == sec' |
+			sort --key=2 |
+			awk --bignum -v sym_addr=${sym_addr#0x} -v sym_size=${sym_size} -v sym_name=${func} -v sec_size=${sec_size} \
+				'$2 == sym_addr && $3 == sym_size && $8 == sym_name { found = 1; next } \
+				found == 1 { size = strtonum("0x" $2) - strtonum("0x" sym_addr); if (size < sym_size) next; found = 2; print size; exit } \
+				END { if (found == 1) print strtonum(sec_size) }')
+
+		if [[ -z $size ]]; then
+			warn "bad symbol size: addr: $sym_addr"
 			DONE=1
 			return
 		fi
-		addr=0x$(printf %x $addr)
 
-		# weed out non-function symbols
-		if [[ $sym_type != t ]] && [[ $sym_type != T ]]; then
-			[[ $print_warnings = 1 ]] &&
-				echo "skipping $func address at $addr due to non-function symbol of type '$sym_type'"
-			continue
+		# Calculate the specified address:
+		local addr=$(($sym_addr + $offset))
+		if [[ -z $addr ]] || [[ $addr = 0 ]]; then
+			warn "bad address: $sym_addr + $offset"
+			DONE=1
+			return
 		fi
+		addr=0x$(printf %x $addr)
 
-		# if the user provided a size, make sure it matches the symbol's size
-		if [[ -n $size ]] && [[ $size -ne $sym_size ]]; then
+		# If the user provided a size, make sure it matches the symbol's size:
+		if [[ -n $user_size ]] && [[ $user_size -ne $size ]]; then
 			[[ $print_warnings = 1 ]] &&
-				echo "skipping $func address at $addr due to size mismatch ($size != $sym_size)"
+				echo "skipping $func address at $addr due to size mismatch ($user_size != $size)"
 			continue;
 		fi
 
-		# make sure the provided offset is within the symbol's range
-		if [[ $offset -gt $sym_size ]]; then
+		# Make sure the provided offset is within the symbol's range:
+		if [[ $offset -gt $size ]]; then
 			[[ $print_warnings = 1 ]] &&
-				echo "skipping $func address at $addr due to size mismatch ($offset > $sym_size)"
+				echo "skipping $func address at $addr due to size mismatch ($offset > $size)"
 			continue
 		fi
 
-		# separate multiple entries with a blank line
-		[[ $FIRST = 0 ]] && echo
-		FIRST=0
+		# In case of duplicates, separate multiple entries with a blank line:
+		[[ $first = 0 ]] && echo
+		first=0
 
-		# pass real address to addr2line
-		echo "$func+$offset/$sym_size:"
-		local file_lines=$(${ADDR2LINE} -fpie $objfile $addr | sed "s; $dir_prefix\(\./\)*; ;")
-		[[ -z $file_lines ]] && return
+		# Pass full address to addr2line:
+		echo "$func+$offset/$size:"
+		local output=$(${ADDR2LINE} -fpie $objfile $addr | sed "s; $dir_prefix\(\./\)*; ;")
+		[[ -z $output ]] && continue
 
 		if [[ $LIST = 0 ]]; then
-			echo "$file_lines" | while read -r line
+			echo "$output" | while read -r line
 			do
 				echo $line
 			done
 			DONE=1;
-			return
+			continue
 		fi
 
-		# show each line with context
-		echo "$file_lines" | while read -r line
+		# If --list was specified, show each line with context:
+		echo "$output" | while read -r line
 		do
 			echo
 			echo $line
@@ -189,7 +204,7 @@ __faddr2line() {
 
 		DONE=1
 
-	done < <(${NM} -n $objfile | awk -v fn=$func -v end=$file_end '$3 == fn { found=1; line=$0; start=$1; next } found == 1 { found=0; print line, "0x"$1 } END {if (found == 1) print line, end; }')
+	done < <(${READELF} --symbols --wide $objfile | awk -v fn=$func '$4 == "FUNC" && $8 == fn')
 }
 
 [[ $# -lt 2 ]] && usage

