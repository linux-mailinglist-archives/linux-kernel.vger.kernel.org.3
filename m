Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32585549BC0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244757AbiFMSjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240749AbiFMSiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:38:03 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE1BD412B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 07:57:52 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id c196so5985456pfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 07:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n1aOeSCucMlesNCCRbsD3f826Lst7fe0VJm8o+wL2qU=;
        b=oXzTTV46vVDTPhtcVK+mb6IMkjk14rzEAtaoq4N3vxKrdtW9TNsDScN0/pwNrYNRp2
         7APpfdbz+9LAmKolpMbZqlnagL7nIV+MRAcanOOZ7XOyMFafp9kEqokLsvfSl1U14VY8
         7FxEvt58JkNHjcwnw8Og1Hrf4QjQldYwGdxEuxZDR4hiyhyEwjm6iEWcU2gIH28woxLQ
         F/JyKMq0WRoEGJklPhruQUgOdXIz/Nm9F9U9zUbpy39GSmhZo/xO1kgY5Jpxoa6OEVij
         1PnajADFxtkIhtXjSZtIiYO1VLnzpyfY8xeojENrPuC4nZfu/vwVgeiqFOY86s0Pe4tX
         RQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n1aOeSCucMlesNCCRbsD3f826Lst7fe0VJm8o+wL2qU=;
        b=fBQP2oSBomnxuld1rgsCb4740pGrvCe81u4+F1WtI+vJeXMXKjzO9lY/XUMpaArKvF
         lm7hQVefSAD1yCSTBMVniO7vMywgok1Qjb8XtBrBb4eA1ci1xQGGg895R7O2wfBy6sDL
         YG042Hp1J6Xt9K6fufTadilUVB4o2LJ0sou11RKP0qlK91X9PReHKBkoSJXqSgzUEDri
         oWg2HYb0odvINGKNO5gPGm7JydqiuJ7zhUn8IqWwX98G9AZ3WWUESO3gIfsdHddbkHVr
         iSCOfyUVaBJMoqEv/dCnPRfYIDE+GRK9lKhc/8N8Y6tB+Ry7H93DT6fJFJEhj4rmU69O
         1LGA==
X-Gm-Message-State: AOAM533TPgBoOSpa2B2tUi94DW6NPxgWYuv21Q/883nvpGvRzy9F0iCi
        HVFhEtT+m1uxCPnZHbdU9NM3nQ==
X-Google-Smtp-Source: ABdhPJxHrXB02Z5WeA2XZERvpC+lUDmE8HYePrbqSnMJcUFAARMn7oQifT4QFxIfpQ7dh9net0mieg==
X-Received: by 2002:a63:d507:0:b0:3fb:22d1:8a51 with SMTP id c7-20020a63d507000000b003fb22d18a51mr9817pgg.377.1655132272169;
        Mon, 13 Jun 2022 07:57:52 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id z11-20020a63b90b000000b003c265b7d4f6sm5540339pge.44.2022.06.13.07.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 07:57:51 -0700 (PDT)
Date:   Mon, 13 Jun 2022 14:57:48 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Anup Patel <anup@brainfault.org>,
        KVM General <kvm@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 000/144] KVM: selftests: Overhaul APIs, purge VCPU_ID
Message-ID: <YqdQbII0x6G0drE4@google.com>
References: <20220603004331.1523888-1-seanjc@google.com>
 <21570ac1-e684-7983-be00-ba8b3f43a9ee@redhat.com>
 <CAAhSdy0_50KshS1rAcOjtFBUu=R7a0uXYa76vNibD_n7s=q6XA@mail.gmail.com>
 <CAAhSdy1N9vwX1aXkdVEvO=MLV7TEWKMB2jxpNNfzT2LUQ-Q01A@mail.gmail.com>
 <YqIKYOtQTvrGpmPV@google.com>
 <YqKRrK7SwO0lz/6e@google.com>
 <a1e80ec8-67dc-bde4-8f17-5aa2b3b1a32a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1e80ec8-67dc-bde4-8f17-5aa2b3b1a32a@redhat.com>
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

On Sat, Jun 11, 2022, Paolo Bonzini wrote:
> On 6/10/22 02:34, Sean Christopherson wrote:
> > I pushed a new version that's based on the current kvm/queue, commit 5e9402ac128b.
> > arm and x86 look good (though I've yet to test on AMD).
> > 
> > Thomas,
> > If you get a chance, could you rerun the s390 tests?  The recent refactorings to
> > use TAP generated some fun conflicts.
> 
> I did so, rebased over David's nested dirty_log_perf_test patches and pushed
> to kvm/queue.

Wahoo!  Thanks!

And a huge thanks to Drew for the reviews!
