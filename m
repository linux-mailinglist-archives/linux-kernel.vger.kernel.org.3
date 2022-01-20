Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A9549530B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377300AbiATRSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:18:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45524 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243820AbiATRR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:17:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642699078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CJh1HGvmik1oSl3vwtmGRyaEFMXvlbmxQO/4aMLRXRo=;
        b=SZewHJ6Clw2bRsvV+VP8q6wR+1O3jnoGfpR4vElZ+YETBgGoRU911jYTmTapwB/EyDrGFO
        f0itEkmKRHcQJ2uGpdFbpTZ89eBWzx6rALUsbhx5JlTEYbflBYiL8ljgQDTyg4/2N4TuCy
        p2ZnjEcn/yVLSNAXKfWL4hdroMVRF7w=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-ozldSBTXNtSZJoxc57JRNw-1; Thu, 20 Jan 2022 12:17:56 -0500
X-MC-Unique: ozldSBTXNtSZJoxc57JRNw-1
Received: by mail-oi1-f197.google.com with SMTP id r11-20020acaa80b000000b002c909592028so4100067oie.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 09:17:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CJh1HGvmik1oSl3vwtmGRyaEFMXvlbmxQO/4aMLRXRo=;
        b=pIWaBGHqDYxPRxbEfeBzlUK/4PKEj6u5ed2uu9AYf/+eUvfhTwr3A7+YPJpDhQ/eq9
         9JBDKPSBcry29yNJNE3Uc37PicJosTvXBZxYe1uAzPbFvsVQLQ8YD2rEpowy/e5Axvrt
         zBS8LVxY1V5Clof2rjEL/Rar9TS69B70jhyVm6lZ5y/02lDEl2s1qoQoB2Y8Tfdqr6B4
         gx3l0a8Vdj/nspja1mwRVH124m6TwuwLMW2GdbNdVTEEy2aKaC7KM7zD9eVb3RPiJVj9
         X+eXy+rSjselWMTSPF5id9yzcrOlD8dIMUpDnfPgIBq723ask8t8c5EzDkc56I9jjYz3
         fD9Q==
X-Gm-Message-State: AOAM530pZsEJiKw2siBfGyMLSJVZrWcDHjgTo67MB+KQb/U7SsLR6Fc4
        MLr88+lTZZdZqtGTp+4MfIthrvN/tsJn0TuFJKFTMBwxiiJjkoaLWrV2RM362aAea+bWDj+n2pt
        eBjL4tgbsToHFhKWizmIBZ2wr
X-Received: by 2002:a05:6808:1146:: with SMTP id u6mr8724754oiu.74.1642699075445;
        Thu, 20 Jan 2022 09:17:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxLtrmApKfardefdgYnLRRYy6LuxE/zoowT409xLYJy1lp5RZNNpuPO9wENkTDEbbqbK1ex8Q==
X-Received: by 2002:a05:6808:1146:: with SMTP id u6mr8724700oiu.74.1642699074897;
        Thu, 20 Jan 2022 09:17:54 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::c])
        by smtp.gmail.com with ESMTPSA id x9sm1448762oto.55.2022.01.20.09.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 09:17:54 -0800 (PST)
Date:   Thu, 20 Jan 2022 09:17:51 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chi-Thanh Hoang <chithanh.hoang@gmail.com>
Subject: Re: Issue using faddr2line on kernel modules
Message-ID: <20220120171751.gibauc4zovoskjns@treble>
References: <CAPDLWs_iSrbXwfKa6CQ0f6H6GE4U88uRhaFgabRjMmSuSEpsiA@mail.gmail.com>
 <20220117194836.vj2rxr3wocrtdx7k@treble>
 <20220117202751.bmwvfsnqxokob6d2@treble>
 <CAPDLWs-yX4FNrmnF3rHrEoHNktcw2Yi8X6qidss-qKpdw=r4RQ@mail.gmail.com>
 <20220118175239.lqxi2ycgeusk5pxl@treble>
 <CAPDLWs_mirot76g==TPRZDsB6Qn99kxw2N5V=PaDYqBLf=ZSCQ@mail.gmail.com>
 <20220119212126.aydgx62abbngumwy@treble>
 <20220119234303.tmebbcrg2vpnri4s@treble>
 <CAPDLWs-DM64k6z3G7qgYwYm=F8piehYhLfaaXc3fDtnBBQiu=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="4lowkj4ypxy2pivw"
Content-Disposition: inline
In-Reply-To: <CAPDLWs-DM64k6z3G7qgYwYm=F8piehYhLfaaXc3fDtnBBQiu=Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4lowkj4ypxy2pivw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Thu, Jan 20, 2022 at 10:44:44AM +0530, Kaiwan N Billimoria wrote:
> On Thu, Jan 20, 2022 at 5:13 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Wed, Jan 19, 2022 at 01:21:29PM -0800, Josh Poimboeuf wrote:
> > > > $ nm -n ./oops_tryv2.ko |grep -C5 do_the_work
> > > > 0000000000000000 r __func__.24215
> > > > 0000000000000000 r __param_bug_in_workq
> > > > 0000000000000000 D __this_module
> > > > 0000000000000000 r _note_7
> > > > 0000000000000000 T cleanup_module
> > > > 0000000000000000 t do_the_work
> > > > 0000000000000000 t do_the_work.cold
> > > > 0000000000000000 b gctx
> > > > 0000000000000000 T init_module
> > > > 0000000000000000 t try_oops_exit
> > > > 0000000000000000 t try_oops_init
> > > > 0000000000000008 b t1
> > > > $
> > > >
> > > > BTW, here's the code:
> > > > https://github.com/PacktPublishing/Linux-Kernel-Debugging/tree/main/ch7/oops_tryv2
> > >
> > > Ok, it looks like the symbols aren't sorted like the code expects.  I
> > > need to do a more robust fix.
> >
> > Ok, please try this instead.  This takes a much more robust approach to
> > the function size calculation, using readelf to confine the symbol
> > search to the section matching the original symbol.
> >
> > This actually has multiple fixes and cleanups, so it'll eventually be
> > split up into a patch set.
> 
> Great. Am facing a few issues though:
> 
> 1. Not sure if it's me but am having issues applying your patches; it
> seems to fail:
> 
> $ patch -p1 --dry-run < ./fa1.patch
> checking file scripts/faddr2line
> Hunk #1 FAILED at 97.
> Hunk #2 FAILED at 110.
> Hunk #3 FAILED at 189.
> 3 out of 3 hunks FAILED
> $

Hm, did you happen to have the older patch already applied?  This should
be applied instead of that one.  Though it's definitely possible I
messed the patch up somehow.

When saving the patch, make sure to preserve the original whitespace.

I'm adding the new patch here as an attachment, if that helps.

> Against which ver are you generating the patch?
> (Am using 5.10.60; i noticed the last commit in mainline was f5f67cc
> in Nov 2018, so vanilla 5.10.60 should be fine, no?).

It was against a newer kernel, but yes, applying it against 5.10.60
should also work.
> 
> 2. I manually applied your patch :)   This is the output I then get:
> 
> $ <...>linux-5.10.60/scripts/faddr2line ./oops_tryv2.ko
> do_the_work+0x16f/0x194 awk: not an option: --bignum bad symbol size:
> addr: 0x0000000000000000 $
> 
> (Not sure if this helps but am running on Ubuntu 20.04; my awk is mawk
> v 1.3.4.20200120-2).

Sorry, I didn't realize mawk was still a thing :-)

Try this one?

----

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 6c6439f69a72..01f28e52f3fc 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -97,86 +97,127 @@ __faddr2line() {
 	local dir_prefix=$3
 	local print_warnings=$4
 
-	local func=${func_addr%+*}
+	local first=1
+	local sym_name=${func_addr%+*}
 	local offset=${func_addr#*+}
 	offset=${offset%/*}
-	local size=
-	[[ $func_addr =~ "/" ]] && size=${func_addr#*/}
+	local user_size=
+	[[ $func_addr =~ "/" ]] && user_size=${func_addr#*/}
 
-	if [[ -z $func ]] || [[ -z $offset ]] || [[ $func = $func_addr ]]; then
+	if [[ -z $sym_name ]] || [[ -z $offset ]] || [[ $sym_name = $func_addr ]]; then
 		warn "bad func+offset $func_addr"
 		DONE=1
 		return
 	fi
 
 	# Go through each of the object's symbols which match the func name.
-	# In rare cases there might be duplicates.
-	file_end=$(${SIZE} -Ax $objfile | awk '$1 == ".text" {print $2}')
-	while read symbol; do
-		local fields=($symbol)
-		local sym_base=0x${fields[0]}
-		local sym_type=${fields[1]}
-		local sym_end=${fields[3]}
-
-		# calculate the size
-		local sym_size=$(($sym_end - $sym_base))
-		if [[ -z $sym_size ]] || [[ $sym_size -le 0 ]]; then
-			warn "bad symbol size: base: $sym_base end: $sym_end"
+	# In rare cases there might be duplicates, in which case we print all
+	# matches.
+	while read line; do
+		local fields=($line)
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
+		local size
+		local next_sym_addr
+		local found=0
+		while read line; do
+			local fields=($line)
+			next_sym_addr=0x${fields[1]}
+			local next_sym_size=${fields[2]}
+			local next_sym_name=${fields[7]:-}
+
+			if [[ $next_sym_addr = $sym_addr ]] &&
+			   [[ $next_sym_size = $sym_size ]] &&
+			   [[ $next_sym_name = $sym_name ]]; then
+				found=1
+				continue
+			fi
+
+			if [[ $found = 1 ]]; then
+				size=$(($next_sym_addr - $sym_addr))
+				[[ $size -lt $sym_size ]] && continue;
+				found=2
+				break
+			fi
+		done < <(${READELF} --symbols --wide $objfile | awk -v sec=$sym_sec '$7 == sec' | sort --key=2)
+
+		if [[ $found = 0 ]]; then
+			warn "can't find symbol: sym_name: $sym_name sym_sec=$sym_sec sym_addr: $sym_addr sym_size: $sym_size"
 			DONE=1
 			return
 		fi
-		addr=0x$(printf %x $addr)
 
-		# weed out non-function symbols
-		if [[ $sym_type != t ]] && [[ $sym_type != T ]]; then
-			[[ $print_warnings = 1 ]] &&
-				echo "skipping $func address at $addr due to non-function symbol of type '$sym_type'"
-			continue
+		[[ $found = 1 ]] && size=$(($sec_size - $sym_addr))
+
+		if [[ -z $size ]] || [[ $size -le 0 ]]; then
+			warn "bad symbol size: sym_addr: $sym_addr next_sym_addr: $next_sym_addr"
+			DONE=1
+			return
 		fi
+		size=0x$(printf %x $size)
 
-		# if the user provided a size, make sure it matches the symbol's size
-		if [[ -n $size ]] && [[ $size -ne $sym_size ]]; then
+		# Calculate the specified address:
+		local addr=$(($sym_addr + $offset))
+		if [[ -z $addr ]] || [[ $addr = 0 ]]; then
+			warn "bad address: $sym_addr + $offset"
+			DONE=1
+			return
+		fi
+		addr=0x$(printf %x $addr)
+
+		# If the user provided a size, make sure it matches the symbol's size:
+		if [[ -n $user_size ]] && [[ $user_size -ne $size ]]; then
 			[[ $print_warnings = 1 ]] &&
-				echo "skipping $func address at $addr due to size mismatch ($size != $sym_size)"
+				echo "skipping $sym_name address at $addr due to size mismatch ($user_size != $size)"
 			continue;
 		fi
 
-		# make sure the provided offset is within the symbol's range
-		if [[ $offset -gt $sym_size ]]; then
+		# Make sure the provided offset is within the symbol's range:
+		if [[ $offset -gt $size ]]; then
 			[[ $print_warnings = 1 ]] &&
-				echo "skipping $func address at $addr due to size mismatch ($offset > $sym_size)"
+				echo "skipping $sym_name address at $addr due to size mismatch ($offset > $size)"
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
+		echo "$sym_name+$offset/$size:"
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
@@ -189,7 +230,7 @@ __faddr2line() {
 
 		DONE=1
 
-	done < <(${NM} -n $objfile | awk -v fn=$func -v end=$file_end '$3 == fn { found=1; line=$0; start=$1; next } found == 1 { found=0; print line, "0x"$1 } END {if (found == 1) print line, end; }')
+	done < <(${READELF} --symbols --wide $objfile | awk -v fn=$sym_name '$4 == "FUNC" && $8 == fn')
 }
 
 [[ $# -lt 2 ]] && usage

--4lowkj4ypxy2pivw
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="faddr2line-fix.patch"

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 6c6439f69a72..01f28e52f3fc 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -97,86 +97,127 @@ __faddr2line() {
 	local dir_prefix=$3
 	local print_warnings=$4
 
-	local func=${func_addr%+*}
+	local first=1
+	local sym_name=${func_addr%+*}
 	local offset=${func_addr#*+}
 	offset=${offset%/*}
-	local size=
-	[[ $func_addr =~ "/" ]] && size=${func_addr#*/}
+	local user_size=
+	[[ $func_addr =~ "/" ]] && user_size=${func_addr#*/}
 
-	if [[ -z $func ]] || [[ -z $offset ]] || [[ $func = $func_addr ]]; then
+	if [[ -z $sym_name ]] || [[ -z $offset ]] || [[ $sym_name = $func_addr ]]; then
 		warn "bad func+offset $func_addr"
 		DONE=1
 		return
 	fi
 
 	# Go through each of the object's symbols which match the func name.
-	# In rare cases there might be duplicates.
-	file_end=$(${SIZE} -Ax $objfile | awk '$1 == ".text" {print $2}')
-	while read symbol; do
-		local fields=($symbol)
-		local sym_base=0x${fields[0]}
-		local sym_type=${fields[1]}
-		local sym_end=${fields[3]}
-
-		# calculate the size
-		local sym_size=$(($sym_end - $sym_base))
-		if [[ -z $sym_size ]] || [[ $sym_size -le 0 ]]; then
-			warn "bad symbol size: base: $sym_base end: $sym_end"
+	# In rare cases there might be duplicates, in which case we print all
+	# matches.
+	while read line; do
+		local fields=($line)
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
+		local size
+		local next_sym_addr
+		local found=0
+		while read line; do
+			local fields=($line)
+			next_sym_addr=0x${fields[1]}
+			local next_sym_size=${fields[2]}
+			local next_sym_name=${fields[7]:-}
+
+			if [[ $next_sym_addr = $sym_addr ]] &&
+			   [[ $next_sym_size = $sym_size ]] &&
+			   [[ $next_sym_name = $sym_name ]]; then
+				found=1
+				continue
+			fi
+
+			if [[ $found = 1 ]]; then
+				size=$(($next_sym_addr - $sym_addr))
+				[[ $size -lt $sym_size ]] && continue;
+				found=2
+				break
+			fi
+		done < <(${READELF} --symbols --wide $objfile | awk -v sec=$sym_sec '$7 == sec' | sort --key=2)
+
+		if [[ $found = 0 ]]; then
+			warn "can't find symbol: sym_name: $sym_name sym_sec=$sym_sec sym_addr: $sym_addr sym_size: $sym_size"
 			DONE=1
 			return
 		fi
-		addr=0x$(printf %x $addr)
 
-		# weed out non-function symbols
-		if [[ $sym_type != t ]] && [[ $sym_type != T ]]; then
-			[[ $print_warnings = 1 ]] &&
-				echo "skipping $func address at $addr due to non-function symbol of type '$sym_type'"
-			continue
+		[[ $found = 1 ]] && size=$(($sec_size - $sym_addr))
+
+		if [[ -z $size ]] || [[ $size -le 0 ]]; then
+			warn "bad symbol size: sym_addr: $sym_addr next_sym_addr: $next_sym_addr"
+			DONE=1
+			return
 		fi
+		size=0x$(printf %x $size)
 
-		# if the user provided a size, make sure it matches the symbol's size
-		if [[ -n $size ]] && [[ $size -ne $sym_size ]]; then
+		# Calculate the specified address:
+		local addr=$(($sym_addr + $offset))
+		if [[ -z $addr ]] || [[ $addr = 0 ]]; then
+			warn "bad address: $sym_addr + $offset"
+			DONE=1
+			return
+		fi
+		addr=0x$(printf %x $addr)
+
+		# If the user provided a size, make sure it matches the symbol's size:
+		if [[ -n $user_size ]] && [[ $user_size -ne $size ]]; then
 			[[ $print_warnings = 1 ]] &&
-				echo "skipping $func address at $addr due to size mismatch ($size != $sym_size)"
+				echo "skipping $sym_name address at $addr due to size mismatch ($user_size != $size)"
 			continue;
 		fi
 
-		# make sure the provided offset is within the symbol's range
-		if [[ $offset -gt $sym_size ]]; then
+		# Make sure the provided offset is within the symbol's range:
+		if [[ $offset -gt $size ]]; then
 			[[ $print_warnings = 1 ]] &&
-				echo "skipping $func address at $addr due to size mismatch ($offset > $sym_size)"
+				echo "skipping $sym_name address at $addr due to size mismatch ($offset > $size)"
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
+		echo "$sym_name+$offset/$size:"
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
@@ -189,7 +230,7 @@ __faddr2line() {
 
 		DONE=1
 
-	done < <(${NM} -n $objfile | awk -v fn=$func -v end=$file_end '$3 == fn { found=1; line=$0; start=$1; next } found == 1 { found=0; print line, "0x"$1 } END {if (found == 1) print line, end; }')
+	done < <(${READELF} --symbols --wide $objfile | awk -v fn=$sym_name '$4 == "FUNC" && $8 == fn')
 }
 
 [[ $# -lt 2 ]] && usage

--4lowkj4ypxy2pivw--

