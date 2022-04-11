Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83644FC74C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 00:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350411AbiDKWFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 18:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbiDKWEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 18:04:48 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC7233E37
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 15:01:43 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x17so19915936lfa.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 15:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZNp2x4iSYzfok2hpXbrlRX9Pkk/fC9iE5eZ1/zNFkm8=;
        b=tCfax1/AYzD7Ti4qMWcS1kyB+xX3oV5rNPQ/YOCcHEKW3JgEnhCdscZ0+8E7cSlvGx
         E8u6ytmc9BqTl5rGhDdk5GlwBiog39gUu8SYkYtNLl6mvYYlbye2jJc7qzG5ZXezdbjC
         WKTneZgzdO16Psvm1hr8FgHjYCGSyuXIyFeSuXsHw5bPXg8wN1vymxJrQDVlWdvIBeYY
         3Gsg2NpFxuS0GWF9QArO5UwK95eYSKhGVEWwuDLQ+5FobVg7RR1dpadylVfxnO4X3nAQ
         cQODHMSD32D2giK1USbkj9lWi/SBg4mUZNblMgDK5IDE2oFrvwqOM/X+gGgwP92kMxfG
         iHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZNp2x4iSYzfok2hpXbrlRX9Pkk/fC9iE5eZ1/zNFkm8=;
        b=yUwyNFBHq0StltxEeXdYomO1XvUwIajdaPQoR+N6R1tN5zXsY3ZJB0F1PBWzM0kDIG
         i50BKxU7sXeAl534HizYO0X/IrXCSSH3PIFJ2CkEHcjoO7C4WTfAWuH3DwyYJ2Dr3MIK
         DKSaybfHr2xO1AnhIbJhbSx1bH5wITJ0id7wJ51fbAEwNn/E2BiPijqP96MdKHB/j/bh
         635A99mfd43YAHW1+8xaM4+qbIUjdtiu/GU8yLuEOokoUAl5HQQTnahBN5AWPBXSF5Eg
         voCXFKE2rOotPevvaFWHRyar5uKR6vDgDVyXdgQhKgR0RvkoQeRtnT//5a0eVFUxnb/6
         sq6w==
X-Gm-Message-State: AOAM5307j6iojqHRodsJEqvSqnmlknB8omL/GuIUhf2BWEEu0Gki2K2V
        IsIItrLm0sAt5wyzdcJfSxxufbHODfvh0G7zr8el/A==
X-Google-Smtp-Source: ABdhPJzBZzoSQ/04f7X9poWesTFRFPDrRVhqC1kx1S7B4XUR3wLKMVXEjRrBmTOJfKqIftiglFojDucp/+LZy6DFHVk=
X-Received: by 2002:a19:674c:0:b0:448:3f49:e6d5 with SMTP id
 e12-20020a19674c000000b004483f49e6d5mr23577490lfj.518.1649714501680; Mon, 11
 Apr 2022 15:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220411211015.3091615-1-bgardon@google.com> <20220411211015.3091615-4-bgardon@google.com>
In-Reply-To: <20220411211015.3091615-4-bgardon@google.com>
From:   David Matlack <dmatlack@google.com>
Date:   Mon, 11 Apr 2022 15:01:15 -0700
Message-ID: <CALzav=fSWOzYZoO8HF5ktuPdqHX7QNb4-dFL7udRPBxhSg_Gng@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] KVM: selftests: Read binary stats desc in lib
To:     Ben Gardon <bgardon@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        David Dunn <daviddunn@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Jing Zhang <jingzhangos@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 2:10 PM Ben Gardon <bgardon@google.com> wrote:
>
> Move the code to read the binary stats descriptors to the KVM selftests
> library. It will be re-used by other tests to check KVM behavior.
>
> No functional change intended.
>
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>  .../selftests/kvm/include/kvm_util_base.h     |  4 +++
>  .../selftests/kvm/kvm_binary_stats_test.c     |  9 ++----
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 29 +++++++++++++++++++
>  3 files changed, 35 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
> index 5ba3132f3110..c5f34551ff76 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> @@ -401,6 +401,10 @@ void assert_on_unhandled_exception(struct kvm_vm *vm, uint32_t vcpuid);
>  int vm_get_stats_fd(struct kvm_vm *vm);
>  int vcpu_get_stats_fd(struct kvm_vm *vm, uint32_t vcpuid);
>  void read_vm_stats_header(int stats_fd, struct kvm_stats_header *header);
> +struct kvm_stats_desc *alloc_vm_stats_desc(int stats_fd,
> +                                         struct kvm_stats_header *header);
> +void read_vm_stats_desc(int stats_fd, struct kvm_stats_header *header,
> +                       struct kvm_stats_desc *stats_desc);

Same feedback here as the previous patch about getting rid of "vm_" in
the function names.

>
>  uint32_t guest_get_vcpuid(void);
>
> diff --git a/tools/testing/selftests/kvm/kvm_binary_stats_test.c b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
> index 22c22a90f15a..e4795bad7db6 100644
> --- a/tools/testing/selftests/kvm/kvm_binary_stats_test.c
> +++ b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
> @@ -62,14 +62,9 @@ static void stats_test(int stats_fd)
>                                                         header.data_offset),
>                         "Descriptor block is overlapped with data block");
>
> -       /* Allocate memory for stats descriptors */
> -       stats_desc = calloc(header.num_desc, size_desc);
> -       TEST_ASSERT(stats_desc, "Allocate memory for stats descriptors");
>         /* Read kvm stats descriptors */
> -       ret = pread(stats_fd, stats_desc,
> -                       size_desc * header.num_desc, header.desc_offset);
> -       TEST_ASSERT(ret == size_desc * header.num_desc,
> -                       "Read KVM stats descriptors");
> +       stats_desc = alloc_vm_stats_desc(stats_fd, &header);
> +       read_vm_stats_desc(stats_fd, &header, stats_desc);
>
>         /* Sanity check for fields in descriptors */
>         for (i = 0; i < header.num_desc; ++i) {
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 0caf28e324ed..e3ae26fbef03 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -2564,3 +2564,32 @@ void read_vm_stats_header(int stats_fd, struct kvm_stats_header *header)
>         ret = read(stats_fd, header, sizeof(*header));
>         TEST_ASSERT(ret == sizeof(*header), "Read stats header");
>  }
> +
> +static ssize_t stats_descs_size(struct kvm_stats_header *header)
> +{
> +       return header->num_desc *
> +              (sizeof(struct kvm_stats_desc) + header->name_size);
> +}
> +
> +/* Caller is responsible for freeing the returned kvm_stats_desc. */
> +struct kvm_stats_desc *alloc_vm_stats_desc(int stats_fd,
> +                                         struct kvm_stats_header *header)
> +{
> +       struct kvm_stats_desc *stats_desc;
> +
> +       stats_desc = malloc(stats_descs_size(header));
> +       TEST_ASSERT(stats_desc, "Allocate memory for stats descriptors");
> +
> +       return stats_desc;
> +}
> +
> +void read_vm_stats_desc(int stats_fd, struct kvm_stats_header *header,
> +                       struct kvm_stats_desc *stats_desc)

Reading the descriptors only needs to be done once per fd. So from an
API point of view I don't think there's value in creating separate
functions for the allocation and the read; just combine them in one.

> +{
> +       ssize_t ret;
> +
> +       ret = pread(stats_fd, stats_desc, stats_descs_size(header),
> +                   header->desc_offset);
> +       TEST_ASSERT(ret == stats_descs_size(header),
> +                   "Read KVM stats descriptors");
> +}
> --
> 2.35.1.1178.g4f1659d476-goog
>
