Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868224B7AF8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 00:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbiBOXDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 18:03:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbiBOXDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 18:03:17 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D03E3891
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 15:03:06 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id v63so624436ybv.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 15:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gjy1DWGz7XMDH1BVnGlNmPqU6Y1sHqvEGxu0Y9G5LwE=;
        b=YAfAKx8GfcP8pKWJ/+OaPew1pdZLZ3ylsnE/dzBsOpm4cp915NUYmh7icmSDjFfOUd
         ha5chsYk5oiJYANFAhOqhGgV6nMVs8G1lXG4P6zVHNtKdlM18pZitMDO0kPBa85PSTNx
         C/1aMzhLjFLNx3mzKbQfVYvryIbhkD1vSk71+yGZh3BItb86gNOvR9el5KbQuPBD7kfZ
         MVKR9q6TIsa6/+BNqnJOjzx0DZsezswCva3Ux0+hKNWk5cVWPEG4yItC5mdZQnkIC1Ob
         sV2HBPa3OQEsn2Vwf+W4Qi1rkDDkipKFtE9k1CYS0iH8x/jUaDmEHT6FR4UO+9Gu8YD6
         XTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gjy1DWGz7XMDH1BVnGlNmPqU6Y1sHqvEGxu0Y9G5LwE=;
        b=txgmX4jG2+sGZMFQGaPczffdj1+kiwMpH3t8yHeiETFzQFx5wnGFRcr+2IsyMQtClO
         wR9nNi4PsQoP9XRt0FLFvvkycooZL6DkeRfFZlPaqv0CaqGuLim7xBkvmG93n3H90BWX
         50/l3MrrK/92Iq94XNDXlZ2CqE8mHUgRNrjvpODho8/TqKrmGMVX6SKKrS+SMGO7mGvB
         +3cGezKtZ+9alLrgFujFS5M3x+JDuFJfgCXa9LVq92MylKDd5fFYhEoniMlOuRVeUjs4
         6n8f1YOV10m5W2luu2KW355NCtZcK+rrzdHapwry2XFy5mcNw1bExzYFKe+hMr7fqCVY
         3YOA==
X-Gm-Message-State: AOAM531mTTGRrEEtVQRGuV3B+Qy3ySFpHHS2kQ5zERb5qauY48Tw4VrT
        XQRyDWzaCvS9KKTa6oU2uJA4RlfM8ItkA3wsBHKMqA==
X-Google-Smtp-Source: ABdhPJykiMCp30Odec40+14zv3WXjkPoENl8LW4sTu4ek5T7KdyJtPD50P2tLUjGN5PeTlwWXMBw153pV9Bs2F/Hrv0=
X-Received: by 2002:a0d:ca57:: with SMTP id m84mr1138094ywd.293.1644966185851;
 Tue, 15 Feb 2022 15:03:05 -0800 (PST)
MIME-Version: 1.0
References: <20220211013032.623763-1-surenb@google.com> <YgvONKdZ2T0PB2/0@dhcp22.suse.cz>
 <YgwDa6rMHRdRTnzB@dhcp22.suse.cz> <YgwHhTN4P5yyZqBz@dhcp22.suse.cz>
In-Reply-To: <YgwHhTN4P5yyZqBz@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 15 Feb 2022 15:02:54 -0800
Message-ID: <CAJuCfpGG9zwbvfH5UZkt6cG=woeO0RGE7QxjEpXn=gFhiaDdmQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] mm: fix use-after-free when anon vma name is used
 after vma is freed
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>, legion@kernel.org,
        ran.xiaokai@zte.com.cn, sashal@kernel.org,
        Chris Hyser <chris.hyser@oracle.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Collingbourne <pcc@google.com>, caoxiaofeng@yulong.com,
        David Hildenbrand <david@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        syzbot+aa7b3d4b35f9dc46a366@syzkaller.appspotmail.com
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

On Tue, Feb 15, 2022 at 12:05 PM Michal Hocko <mhocko@suse.com> wrote:
>
> One thing I was considering is to check agains ref counte overflo (a
> deep process chain with many vmas could grow really high. ref_count
> interface doesn't provide any easy way to check for overflows as far as
> I could see from a quick glance so I gave up there but the logic would
> be really straightforward. We just create a new anon_vma_name with the same
> content and use it when duplicating if the usage grow really
> (arbitrarily) high.

I went over proposed changes. I see a couple small required fixes
(resetting the name to NULL seems to be missing and I think
dup_vma_anon_name needs some tweaking) but overall quite
straight-forward. I'll post a separate patch to do this refactoring.
The original patch is fixing the UAF issue, so I don't want to mix it
with refactoring. Please let me know if you see an issue with
separating it that way.
Thanks,
Suren.


> --
> Michal Hocko
> SUSE Labs
