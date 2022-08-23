Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D6459CD2F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 02:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239089AbiHWAYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 20:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237871AbiHWAYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 20:24:42 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EBF3DF1A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 17:24:36 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-3378303138bso298948557b3.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 17:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=6+1zWJmH8QXj8X4FXqMGXd6ZgOyPA1Adef25hUn+KAU=;
        b=PWiv/pt0eSkF0f8mONhhv3hdl89iPmgPtUC9QM8RGL1OWPKWRZ9wY0lMUjFTEUMKsc
         3hM5t30SApCzUy1DygscsE6x4XTmaiZlcEChFHEzbWyVLKdxNuA0HivzYEWnIaveOxS8
         WEnphSUR3k+YjfElipFI3Yttz7grHqKyX6Yay4WoEwNpeicYVWtNkvVrIjF/ckciDzAM
         YBQjrMSrBtQcEsc9P9jW2lVqPXyLKT0sNFcXB3wIbvizqxm1xU8rTANVDZ0PKLsL+W5S
         NmIdB+O3irgvNYyWgb5v0ggWJHpOfCuI5Xg2QLVo327IF3nUVJO8p28HohVdXD8W6AGe
         ik0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=6+1zWJmH8QXj8X4FXqMGXd6ZgOyPA1Adef25hUn+KAU=;
        b=X/fYd0Qlgk3DSC28FB8Lt6ebVmGKNzW30q6SJiSHaqz8HMbABfPoZK3MEug2zooIGk
         CBOR+w09zOqKjIbrU+mKnL5NCoY+Qv8+WgBgMoEW37BkLtBpwMXG+l7QSUwC1RTDyoGZ
         1lCLm/8lZZmLaMr2ZkjgPaIvfMeBXEv7db+QZHJ33j1+tpDpZJQPoZKM2PSxdW2ODl+u
         81JNpxJ0Lar+ldufuBHlw4uI8PKwb/7GxwLwKTnbG5xjtAQ+DVNOo8mKXe0cUh/7PNd4
         LvqUKW8WXRBzkD+coswNCQLctWL09oTSs3PMoA37+MNjAVWtJ25qmPqSyxbiXCgo870f
         eTGw==
X-Gm-Message-State: ACgBeo0NAWZYeHo0Yyd1YUX6jugnp0fIvIiaeisSfl3d2GiW5Yhj8HtM
        WqHvF04l5T2nlnoVdCaikreOIdxXdHvo9sE3KklgoA==
X-Google-Smtp-Source: AA6agR6yvCKBCw+9E6wATTIinr+YX84YW2LwjVVwyCqtO3HtSsO1BKM6CnGmBMZ5AHNoc00BYjO2CRpOe4a5YC191gw=
X-Received: by 2002:a25:40c5:0:b0:694:e710:a26 with SMTP id
 n188-20020a2540c5000000b00694e7100a26mr17417813yba.509.1661214275620; Mon, 22
 Aug 2022 17:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <cover.1659103274.git.thomas.lendacky@amd.com> <44495aa8acb666b447a08a1c3af80987aa3cea3a.1659103274.git.thomas.lendacky@amd.com>
In-Reply-To: <44495aa8acb666b447a08a1c3af80987aa3cea3a.1659103274.git.thomas.lendacky@amd.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Mon, 22 Aug 2022 17:24:24 -0700
Message-ID: <CAAH4kHakyK06eqQhaagdMmvPq6vsWK51k-f4UgUZWzexZOuBLg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] x86/sev: Add SNP-specific unaccepted memory support
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> +void snp_accept_memory(phys_addr_t start, phys_addr_t end)
> +{
> +       unsigned long vaddr;
> +       unsigned int npages;
> +
> +       if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
> +               return;
> +
> +       vaddr = (unsigned long)__va(start);
> +       npages = (end - start) >> PAGE_SHIFT;
> +
> +       set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
> +
> +       pvalidate_pages(vaddr, npages, true);
> +}

My testing of this patch shows that a significant amount of time is
spent using the MSR protocol to change page state, in such a
significant fashion that it's slower than eagerly accepting all
memory. The difference gets worse as the RAM size goes up, so I think
there's some phase problem with the GHCB protocol not getting used
early enough?

-- 
-Dionna Glaze, PhD (she/her)
