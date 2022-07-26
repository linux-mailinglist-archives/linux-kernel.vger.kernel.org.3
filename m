Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F1F5808A2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 02:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbiGZABZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 20:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbiGZABJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 20:01:09 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1249D6437
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 17:01:09 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so11701455pjf.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 17:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0dYvPu1lOmSURZ4u1yzsn5bYOoklceFkBHw6I6SfqqE=;
        b=sz3gGFksK1BfrO8x90Bhjlv/p0tPPvagwonKdWEQuRJeX5nF0oNoekwXs9h2vRXUqd
         PaYqu87ZDCZo540HyoopZk6LTHa3e5m1R+A2RQUQ9RMqx2/hsmMWl3PZsIutmjZlhfkf
         a5Gx2f3c3+Q5iPyJMTASG/4OXGocWp2qgTZ+OMIujwYuKYLZ5FmMlmDPNpX0oeWSGgbC
         af7gVPTPcQ2h9Bljguy1e2qOZvSygHOWWqFZKnaPWw70SXSDXmyOz3Bap+gzlrTyYnVi
         rKm6sjJfmWSgyvuhjC+u8sfNspeiDkpNLp7kt2nmwWimuEj0F+1Gv4ZlcimP9nvl0PNh
         5bVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0dYvPu1lOmSURZ4u1yzsn5bYOoklceFkBHw6I6SfqqE=;
        b=hbnGEK87Cw+o+adEb50jSKG7TdLwb0IHx4+MQJYd5j67+XHTg0nwcrBXWek3aeplre
         XAAzVVzgRm0oL+RmNvorHw+sD22/aiFg0f0oLt0szf4MJ+2pwV4zDNYQh7yr8QAf8ASw
         smr5A2gcQEuK3f9LjRoybn+T5c7fQL/KDKoaICU3tlk+bCJKNlBoxKtoCCozh/KfVhdd
         F9s/F/WkBcbRys2K7vXLYLie1RWQyKhJYMU5562UpVxxe0jSxTJA3dZM4UjTY249bc9l
         vmhb2HaMl5BI5TrBrh9eb4tmjPk4tu5XPfxTXLIPMDzSbfNbYMejb6ls5VareY9UmTTn
         jfSw==
X-Gm-Message-State: AJIora+A6a2wtWakDftRyhyXVozavcg74hLwe3EwAQooDyleB94Zi/oY
        uwV8JfCZ6yirT1uDjLyAL7PoyQ==
X-Google-Smtp-Source: AGRyM1v3fX8z27lVE4u/pIWm/nIz9V+jtafbKCMd4teZyXoH+xJj3ZjgT6zzJsvERtFbk+h+yNi+hQ==
X-Received: by 2002:a17:90b:4f87:b0:1f2:8a32:ca06 with SMTP id qe7-20020a17090b4f8700b001f28a32ca06mr12286134pjb.242.1658793668453;
        Mon, 25 Jul 2022 17:01:08 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id s27-20020a63525b000000b00419b02043e1sm8906139pgl.38.2022.07.25.17.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 17:01:07 -0700 (PDT)
Date:   Tue, 26 Jul 2022 00:01:04 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Matlack <dmatlack@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Ben Gardon <bgardon@google.com>
Subject: Re: [PATCH v2 1/6] KVM: x86/mmu: Tag disallowed NX huge pages even
 if they're not tracked
Message-ID: <Yt8uwMt/3JPrSWM9@google.com>
References: <20220723012325.1715714-1-seanjc@google.com>
 <20220723012325.1715714-2-seanjc@google.com>
 <Yt8eC2OyolG9QE3g@google.com>
 <Yt8mo6XbT/60UcpS@google.com>
 <CALzav=esXG1yekYk1zCtLt3VGsuGJKYycBhUgtgwiU8w1Anucw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALzav=esXG1yekYk1zCtLt3VGsuGJKYycBhUgtgwiU8w1Anucw@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022, David Matlack wrote:
> On Mon, Jul 25, 2022 at 4:26 PM Sean Christopherson <seanjc@google.com> wrote:
> > The only scenario that jumps to mind is the non-coherent DMA with funky MTRRs
> > case.  There might be others, but it's been a while since I wrote this...
> >
> > The MTRRs are per-vCPU (KVM really should just track them as per-VM, but whatever),
> > so it's possible that KVM could encounter a fault with a lower fault->req_level
> > than a previous fault that set nx_huge_page_disallowed=true (and added the page
> > to the possible_nx_huge_pages list because it had a higher req_level).
> 
> But in that case the lower level SP would already have been installed,
> so we wouldn't end up calling account_nx_huge_page() and getting to
> this point. (account_nx_huge_page() is only called when linking in an
> SP.)

Hrm, true.  I'm 99% certain past me was just maintaining the existing logic in
account_huge_nx_page()

	if (sp->lpage_disallowed)
		return;

Best thing might be to turn that into a WARN as the first patch?

> Maybe account_nx_huge_page() needs to be pulled out and called for
> every SP on the walk during a fault?

Eh, not worth it, the MTRR thing is bogus anyways, e.g. if vCPUs have different
MTRR settings and one vCPU allows a huge page but the other does not, KVM will
may or may not install a huge page depending on which vCPU faults in the page.
