Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFBB7486B00
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 21:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243661AbiAFUVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 15:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243652AbiAFUVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 15:21:47 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E99C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 12:21:47 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id o20so6592714uat.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 12:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TsNggRXYkwV4EUR9Ok29kqBUnZM3s7RXs5GPcRvP5bA=;
        b=QURTZ5evJ1YW/IO1Blizmr5ol7XadBDlAr3gAsHzRzmWyPahRo6daBfqWicPAoCORh
         FRNwZ1ayYFfTQc/EiGApBPDjjccy87v0oItyC4AuAkdssyGcG+FFgiC+KinME422CSSu
         6kvNSr98Yq7+p9iJ7bTmWyQpCYpWfwBR8a9+EpxgSAtGrLs5JnpAF6eVSHvXJAVYLCyK
         TlQGfEAImvJw5xoAZKN3fQJTri+FCqMqmtZp06a1oaViYnvhyJCOlcKdTIZsL4MPlgH9
         OsTYsbgv4oIh7A27qQabDEn9MOEuvITSFRuWp98w2RxhINCS7ltPI2XoJvOmiagsRffz
         X++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TsNggRXYkwV4EUR9Ok29kqBUnZM3s7RXs5GPcRvP5bA=;
        b=hbJmq4hvEZF90Wr2qZdzoty81dliOrRR72Mz9OgbOPTYwfL+F62UPToC582tu6y5bD
         2ClnXljHfC98n1OcjpYZSEpvHTVEehNT+iGmLlNfbAhEcm3I59SQZ0oDtzitiA8SXN+N
         3eiyz7eoM2YAC7OxeEcI+SOGLC8KqgMS/2RM9ESoGG1A6VOMClBrDG/BaFanYAiNTw0r
         uguBjV62Lzh5wM6rYgY/jLSVap+6j8vFB3YzLOv0mlJfJ/h9DqRpCahAufJgbjAhf/2S
         0pnZM2qR27KGRwsMmzNLI1QHy3fksTEn4rFmolbbapegEFIv8pNl6gB4j4Q7dKBoUPFm
         V+zg==
X-Gm-Message-State: AOAM531Ac8qcCWcl9C6kXROtsQps89QkWqWCZZJNhT4aYclN/gcl0BKY
        eyw9izLCieXXPrZE/AonAmR/PCoNTabDMkwD/vudpA==
X-Google-Smtp-Source: ABdhPJzxS3KUNw3tMwcrQJ3mdU2fzU0rZ/yi/kaPmi9KKMyMy9+ysGpHcGAVx5HN1pdKrJLf6dIaVj+7VV2O0XGWm70=
X-Received: by 2002:ab0:2a48:: with SMTP id p8mr20072842uar.125.1641500506544;
 Thu, 06 Jan 2022 12:21:46 -0800 (PST)
MIME-Version: 1.0
References: <20220106201359.1646575-1-longman@redhat.com>
In-Reply-To: <20220106201359.1646575-1-longman@redhat.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 6 Jan 2022 12:21:35 -0800
Message-ID: <CAHS8izMArAqzt_hNdw=84Te1RHXkBmMmHXVwHazhkFL60Mx4tw@mail.gmail.com>
Subject: Re: [PATCH] selftests/vm: Make charge_reserved_hugetlb.sh work with
 existing cgroup setting
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 12:14 PM Waiman Long <longman@redhat.com> wrote:
>
> The hugetlb cgroup reservation test charge_reserved_hugetlb.sh assume
> that no cgroup filesystems are mounted before running the test. That is
> not true in many cases. As a result, the test fails to run. Fix that by
> querying the current cgroup mount setting and using the existing cgroup
> setup instead before attempting to freshly mount a cgroup filesystem.
>
> Similar change is also made for hugetlb_reparenting_test.sh as well,
> though it still has problem if cgroup v2 isn't used.
>
> The patched test scripts were run on a centos 8 based system to verify
> that they ran properly.
>
> Fixes: 29750f71a9b4 ("hugetlb_cgroup: add hugetlb_cgroup reservation tests")
> Signed-off-by: Waiman Long <longman@redhat.com>

Thank you very much.

Acked-by: Mina Almasry <almasrymina@google.com>

> ---
>  .../selftests/vm/charge_reserved_hugetlb.sh   | 34 +++++++++++--------
>  .../selftests/vm/hugetlb_reparenting_test.sh  | 21 +++++++-----
>  .../selftests/vm/write_hugetlb_memory.sh      |  2 +-
>  3 files changed, 34 insertions(+), 23 deletions(-)
>  mode change 100644 => 100755 tools/testing/selftests/vm/charge_reserved_hugetlb.sh
>  mode change 100644 => 100755 tools/testing/selftests/vm/hugetlb_reparenting_test.sh
>  mode change 100644 => 100755 tools/testing/selftests/vm/write_hugetlb_memory.sh
>
> diff --git a/tools/testing/selftests/vm/charge_reserved_hugetlb.sh b/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
> old mode 100644
> new mode 100755
> index fe8fcfb334e0..a5cb4b09a46c
> --- a/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
> +++ b/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
> @@ -24,19 +24,23 @@ if [[ "$1" == "-cgroup-v2" ]]; then
>    reservation_usage_file=rsvd.current
>  fi
>
> -cgroup_path=/dev/cgroup/memory
> -if [[ ! -e $cgroup_path ]]; then
> -  mkdir -p $cgroup_path
> -  if [[ $cgroup2 ]]; then
> +if [[ $cgroup2 ]]; then
> +  cgroup_path=$(mount -t cgroup2 | head -1 | awk -e '{print $3}')
> +  if [[ -z "$cgroup_path" ]]; then
> +    cgroup_path=/dev/cgroup/memory
>      mount -t cgroup2 none $cgroup_path
> -  else
> +    do_umount=1
> +  fi
> +  echo "+hugetlb" >$cgroup_path/cgroup.subtree_control
> +else
> +  cgroup_path=$(mount -t cgroup | grep ",hugetlb" | awk -e '{print $3}')
> +  if [[ -z "$cgroup_path" ]]; then
> +    cgroup_path=/dev/cgroup/memory
>      mount -t cgroup memory,hugetlb $cgroup_path
> +    do_umount=1
>    fi
>  fi
> -
> -if [[ $cgroup2 ]]; then
> -  echo "+hugetlb" >/dev/cgroup/memory/cgroup.subtree_control
> -fi
> +export cgroup_path
>
>  function cleanup() {
>    if [[ $cgroup2 ]]; then
> @@ -108,7 +112,7 @@ function setup_cgroup() {
>
>  function wait_for_hugetlb_memory_to_get_depleted() {
>    local cgroup="$1"
> -  local path="/dev/cgroup/memory/$cgroup/hugetlb.${MB}MB.$reservation_usage_file"
> +  local path="$cgroup_path/$cgroup/hugetlb.${MB}MB.$reservation_usage_file"
>    # Wait for hugetlbfs memory to get depleted.
>    while [ $(cat $path) != 0 ]; do
>      echo Waiting for hugetlb memory to get depleted.
> @@ -121,7 +125,7 @@ function wait_for_hugetlb_memory_to_get_reserved() {
>    local cgroup="$1"
>    local size="$2"
>
> -  local path="/dev/cgroup/memory/$cgroup/hugetlb.${MB}MB.$reservation_usage_file"
> +  local path="$cgroup_path/$cgroup/hugetlb.${MB}MB.$reservation_usage_file"
>    # Wait for hugetlbfs memory to get written.
>    while [ $(cat $path) != $size ]; do
>      echo Waiting for hugetlb memory reservation to reach size $size.
> @@ -134,7 +138,7 @@ function wait_for_hugetlb_memory_to_get_written() {
>    local cgroup="$1"
>    local size="$2"
>
> -  local path="/dev/cgroup/memory/$cgroup/hugetlb.${MB}MB.$fault_usage_file"
> +  local path="$cgroup_path/$cgroup/hugetlb.${MB}MB.$fault_usage_file"
>    # Wait for hugetlbfs memory to get written.
>    while [ $(cat $path) != $size ]; do
>      echo Waiting for hugetlb memory to reach size $size.
> @@ -574,5 +578,7 @@ for populate in "" "-o"; do
>    done     # populate
>  done       # method
>
> -umount $cgroup_path
> -rmdir $cgroup_path
> +if [[ $do_umount ]]; then
> +  umount $cgroup_path
> +  rmdir $cgroup_path
> +fi
> diff --git a/tools/testing/selftests/vm/hugetlb_reparenting_test.sh b/tools/testing/selftests/vm/hugetlb_reparenting_test.sh
> old mode 100644
> new mode 100755
> index 4a9a3afe9fd4..bf2d2a684edf
> --- a/tools/testing/selftests/vm/hugetlb_reparenting_test.sh
> +++ b/tools/testing/selftests/vm/hugetlb_reparenting_test.sh
> @@ -18,19 +18,24 @@ if [[ "$1" == "-cgroup-v2" ]]; then
>    usage_file=current
>  fi
>
> -CGROUP_ROOT='/dev/cgroup/memory'
> -MNT='/mnt/huge/'
>
> -if [[ ! -e $CGROUP_ROOT ]]; then
> -  mkdir -p $CGROUP_ROOT
> -  if [[ $cgroup2 ]]; then
> +if [[ $cgroup2 ]]; then
> +  CGROUP_ROOT=$(mount -t cgroup2 | head -1 | awk -e '{print $3}')
> +  if [[ -z "$CGROUP_ROOT" ]]; then
> +    CGROUP_ROOT=/dev/cgroup/memory
>      mount -t cgroup2 none $CGROUP_ROOT
> -    sleep 1
> -    echo "+hugetlb +memory" >$CGROUP_ROOT/cgroup.subtree_control
> -  else
> +    do_umount=1
> +  fi
> +  echo "+hugetlb +memory" >$CGROUP_ROOT/cgroup.subtree_control
> +else
> +  CGROUP_ROOT=$(mount -t cgroup | grep ",hugetlb" | awk -e '{print $3}')
> +  if [[ -z "$CGROUP_ROOT" ]]; then
> +    CGROUP_ROOT=/dev/cgroup/memory
>      mount -t cgroup memory,hugetlb $CGROUP_ROOT
> +    do_umount=1
>    fi
>  fi
> +MNT='/mnt/huge/'
>
>  function get_machine_hugepage_size() {
>    hpz=$(grep -i hugepagesize /proc/meminfo)
> diff --git a/tools/testing/selftests/vm/write_hugetlb_memory.sh b/tools/testing/selftests/vm/write_hugetlb_memory.sh
> old mode 100644
> new mode 100755
> index d3d0d108924d..70a02301f4c2
> --- a/tools/testing/selftests/vm/write_hugetlb_memory.sh
> +++ b/tools/testing/selftests/vm/write_hugetlb_memory.sh
> @@ -14,7 +14,7 @@ want_sleep=$8
>  reserve=$9
>
>  echo "Putting task in cgroup '$cgroup'"
> -echo $$ > /dev/cgroup/memory/"$cgroup"/cgroup.procs
> +echo $$ > ${cgroup_path:-/dev/cgroup/memory}/"$cgroup"/cgroup.procs
>
>  echo "Method is $method"
>
> --
> 2.27.0
>
