Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BF74E933C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240635AbiC1LVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240607AbiC1LU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:20:28 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB02D55763
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:18:44 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id p15so24085543lfk.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:date:message-id:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=N926ipqlEwj4JO1xTcsrXgCa3AA/3fWt5Bm+xv75a5E=;
        b=nz38DioMMu/o2OpQIzvPDjyYpPLI0nFTsULpn2HmsTcsJvQZ7J3CkBnphloPw/Ek/T
         2CV+PcbPozG279+rNdUW64wR5Lus3yn2+g8JB1OkBnfK5htgoQWDS96xU71x8XM0aTQU
         sAcs5TpXaQsXWw/zxSInITGD+LUo1YTEVbGIXjV2kacYbDBhB4V77jA5kws+Pwmu0oB+
         t4E9Z1LlRbV/W9IwBJE+V31v5+z4BE10KhA4+5wQxU0iqiSMFAVy+tuumRZ04PkQLUXF
         EsdqqJilrhiXX60X0ERWCPIGdY7mjYiH0a7Z+COTeBRi4Kyr5YoSxc9fHyqtCW19qww3
         PTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=N926ipqlEwj4JO1xTcsrXgCa3AA/3fWt5Bm+xv75a5E=;
        b=UiRv5OZx+ijkJGZXOovm2UIA1n3niGI4TwQ6mOgf7S4RxXLu0+xigkKo54gF89J7Pu
         7yeSdcG1UVCHdZDy/sZiIRAzhZeU3P+6wfGKnAEqIvsekCqZcXwBDHeS30b3HIjoiMp6
         xN6Wr/GctYPZ61ma4ygoq+v/k0mqLcpvtNlEHpvCZxYmcYA6m5V24hrtw/wXZ534+7rY
         wwIN6KV5ZkJlh3n4E/yuOLx0kQdVLelsL64O2aqBkZE5s2kodRd0r1ZAkUpRo1iI/iV/
         fRFMCrg11a5eSVHFeSjjeryYqB86CZFkFLYm/bSAVvWrT3Sz3qLvp1k5Zz1TnFGbinzZ
         n4ow==
X-Gm-Message-State: AOAM532vXBYErWKNCJL56gdXe+VbjOWj0ynZAgarJaKOjH+qVgnKqQj2
        YnkwxpcrBE25NaerlJ9oEwpTUQVU4Bqp8+iX
X-Google-Smtp-Source: ABdhPJwe/gX2NWrPoEuwfjHT3h0n/GqZ0JM31cCteh0vGnsgz/4AYMDMtb0HtiAGvAasyUXkJKGZ5w==
X-Received: by 2002:ac2:43bb:0:b0:44a:1ee6:8c12 with SMTP id t27-20020ac243bb000000b0044a1ee68c12mr19628435lfl.683.1648466323220;
        Mon, 28 Mar 2022 04:18:43 -0700 (PDT)
Received: from [127.0.1.1] ([2.92.192.17])
        by smtp.gmail.com with ESMTPSA id t19-20020a199113000000b0044a2d7a1f4asm1601632lfd.206.2022.03.28.04.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 04:18:42 -0700 (PDT)
Subject: [PATCH 4/4] dm-qcow2: Add helper for working with dm-qcow2 devices
From:   Kirill Tkhai <kirill.tkhai@openvz.org>
To:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        song@kernel.org, linux-kernel@vger.kernel.org,
        khorenko@virtuozzo.com, kirill.tkhai@openvz.org
Date:   Mon, 28 Mar 2022 14:18:41 +0300
Message-ID: <164846632180.251310.3616379476259718920.stgit@pro>
In-Reply-To: <164846619932.251310.3668540533992131988.stgit@pro>
References: <164846619932.251310.3668540533992131988.stgit@pro>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This scripts allows to create and remove dm-qcow2 device,
create internal snapshot, resize virtual device size,
or check image consistency on live device.

Signed-off-by: Kirill Tkhai <kirill.tkhai@openvz.org>
---
 scripts/qcow2-dm.sh |  249 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 249 insertions(+)
 create mode 100755 scripts/qcow2-dm.sh

diff --git a/scripts/qcow2-dm.sh b/scripts/qcow2-dm.sh
new file mode 100755
index 000000000000..7d9bda44c1d6
--- /dev/null
+++ b/scripts/qcow2-dm.sh
@@ -0,0 +1,249 @@
+#!/bin/bash
+#
+# This requires parameter dm_qcow2.kernel_sets_dirty_bit=y
+
+usage () {
+    cat <<EOF
+Usage:
+	$prog_name create <file.qcow2> <dev_name>
+	$prog_name remove <file.qcow2>
+	$prog_name check [qemu-img check optional args] <file.qcow2>
+	$prog_name snapshot [qemu-img snapshot optional args] <file.qcow2>
+	$prog_name resize [qemu-img resize optional args] <file.qcow2> [+ | -]size
+EOF
+}
+
+get_img_size () {
+	sz=`qemu-img info -f qcow2 $1 | grep "virtual size" | sed 's/.*(\(.*\) bytes)/\1/'`
+	echo $sz
+}
+
+get_nr_imgs () {
+	nr=`echo $1 | sed "s/.*qcow2 \(\w\) .*$/\1/"`
+	echo $nr
+}
+
+get_dev_of_image () {
+	abs_path=$1
+
+	while read line; do
+		dev=`echo $line | sed "s/:.*//"`
+		nr_imgs=$(get_nr_imgs "$line")
+		top_img_id=$((nr_imgs - 1))
+
+		top_img_path=`dmsetup message $dev 0 get_img_name $top_img_id`
+		if [ -z "$top_img_path" ]; then
+			echo >&2 "Error during search of device"; exit 1;
+			return 1
+		fi
+
+		if [ "$abs_path" != "$top_img_path" ]; then
+			continue
+		fi
+
+		echo $dev
+		return 0
+
+	done < <(LANG=C dmsetup table --target=qcow2 | grep -v "No devices found")
+
+	return 0
+}
+
+create () {
+	if [ "$#" -ne 2 ]; then
+		echo >&2 "Wrong number of arguments."; usage; exit 1;
+	fi
+
+	file=$1
+	dev=$2
+	files=()
+	fds=""
+
+	qemu-img check $file || exit 1
+
+	disk_sz=$(get_img_size "$file")
+	echo disk_sz=$disk_sz
+	if [ -z "$disk_sz" ]; then
+		echo "Can't get disk size."; exit 1;
+	fi
+
+	while :; do
+		if [ ! -f "$file" ]; then
+			echo "$file does not exist."; exit 1;
+		fi
+
+		files+=("$file")
+
+		exec {fd}<>$file || exit 1
+		flock -x $fd || exit 1
+		fds="$fd $fds"
+
+		file=`qemu-img info $file | grep "backing file:" | sed "s/backing file: //"`
+		if [ -z "$file" ]; then
+			break
+		fi
+	done
+
+	echo "Create device [$dev] of size $disk_sz from [${files[*]}]."
+	dmsetup create $dev --table "0 $((disk_sz / 512)) qcow2 ${fds}"
+}
+
+reload_device () {
+	disk_sz=$(get_img_size "$abs_path")
+	if [ -z "$disk_sz" ]; then
+		echo "Can't get disk size."; return;
+	fi
+
+	line=`dmsetup table $dev`
+	nr_imgs=$(get_nr_imgs "$line")
+	top_img_id=$((nr_imgs - 1))
+	fds=""
+
+	for id in `seq 0 $top_img_id`;
+	do
+		file=`dmsetup message $dev 0 get_img_name $id`
+		if [ -z "$file" ]; then
+			echo "Can't get image file."; return;
+		fi
+		exec {fd}<>$file || exit 1
+
+		fds="$fds $fd"
+	done
+
+	echo "Reloading $dev."
+	dmsetup reload $dev --table "0 $((disk_sz / 512)) qcow2 ${fds}"
+}
+
+remove () {
+	if [ "$#" -ne 1 ]; then
+		echo >&2 "Wrong number of arguments."; usage; exit 1;
+	fi
+	user_path=$1
+	abs_path=`realpath $user_path`
+
+	dev=$(get_dev_of_image "$abs_path")
+	if [ -z "$dev" ]; then
+		echo >&2 "Can't find device with [$user_path] top image."; exit 1
+	fi
+
+	echo "Removing device [$dev]."
+	dmsetup remove $dev
+	ret=$?
+
+	if [ $ret -eq 0 ]; then
+		#Sanity check
+		echo "Checking [$abs_path]."
+		qemu-img check $abs_path
+	fi
+	exit $ret
+}
+
+qemu_img () {
+	wants_reload=0
+	if [ $1 == "--wants_reload" ]; then
+		wants_reload=1
+		shift
+	fi
+
+	if [ "$#" -lt 3 ]; then
+		echo >&2 "Wrong number of arguments."; usage; exit 1;
+	fi
+
+	user_path=$1
+	cmd=$2
+	abs_path=`realpath $user_path`
+	qemu_img_args=${@: 2}
+
+	dev=$(get_dev_of_image "$abs_path")
+	if [ -z "$dev" ]; then
+		echo >&2 "Can't find device by [$user_path]."; return 1
+	fi
+
+	echo "Suspending $dev."
+	dmsetup suspend $dev || exit 1
+
+	if [ "$cmd" != "check" ]; then
+		echo "Checking $abs_path"
+		qemu-img check $abs_path
+		ret=$?
+		if [ $ret -ne 0 ]; then
+			echo "Resuming $dev."
+			dmsetup resume $dev
+			exit 1
+		fi
+	fi
+
+	echo "===== Call:  qemu-img $qemu_img_args. ====="
+	qemu-img $qemu_img_args
+	ret=$?
+	if [ $ret -ne 0 ]; then
+		echo >&2 "Failed during qemu-img call."
+	fi
+	echo "===== End of qemu-img $qemu_img_args. ====="
+
+	if [ $wants_reload -ne 0 ]; then
+		reload_device $dev $abs_path
+	fi
+
+	echo "Resuming $dev."
+	dmsetup resume $dev || exit 1
+	if [ $? -ne 0 ]; then
+		ret=$?
+	fi
+
+	return $ret
+}
+
+check () {
+	user_path=${@: -1}
+	qemu_img_args=$@
+
+	qemu_img $user_path check $qemu_img_args
+	return $?
+}
+
+snapshot () {
+	user_path=${@: -1}
+	qemu_img_args=$@
+
+	qemu_img $user_path snapshot $qemu_img_args
+	return $?
+}
+
+resize () {
+	user_path=${@:(-2):1}
+	qemu_img_args=$@
+
+	qemu_img --wants_reload $user_path resize $qemu_img_args
+	return $?
+}
+
+prog_name=$(basename $0)
+
+case $1 in
+	"create")
+		shift
+		create "$@"
+		exit 0
+		;;
+	"remove")
+		shift
+		remove "$@"
+		;;
+	"check")
+		shift
+		check "$@"
+		;;
+	"snapshot")
+		shift
+		snapshot "$@"
+		;;
+	"resize")
+		shift
+		resize "$@"
+		;;
+	*)
+		usage
+		exit 1
+	        ;;
+esac


