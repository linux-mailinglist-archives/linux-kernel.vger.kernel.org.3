Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE1D577BE3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 08:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbiGRGr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 02:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiGRGr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 02:47:26 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EB515A3A
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 23:47:22 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id r2so8162041qta.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 23:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=CxwxaDVgue0TLlkqxh1Fx5Wl0sMETEThFBBYudThPAM=;
        b=H+UuJsNyKDvw1n9H1k+7Bzi4IfrGrJlJ+FBtYdOotBBc1Fy++8aN1z+zX38Ks+nMLU
         yqbepoXNUqbukUDYaENTap76agS+vPDg2qrlQS0fcX8Q3AiTboQLQafEhG0GR5d2xbbQ
         KEFkNkX8qchC9rSio2+EfgOSYJrUCEk3qL7X16+RIcufBF+S13t6mBomNPlVtSKxP+ek
         dMAPtzmL7m4Lx+H2Qm+P+Pe3/8nuXBMmxHmv989XwGiNKYglVfrt2IxKTibXdMT2JN4y
         lT2uiJ3ZiluA1rr52lXyCK0euw/oPeZU0q89x8UHuxuOVJdfjUv9G4FvBdXiq83U5NAU
         Be+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=CxwxaDVgue0TLlkqxh1Fx5Wl0sMETEThFBBYudThPAM=;
        b=PlQtXnEnT+2Q10qSo1IU9idNlJlTJpjW6DxP3y0tlDaNPFwaNEwmQfEhF2ZY5xFasN
         DBNyr/XHrW9KbRvWHKRU4nXxS35uUI6di0js1blfiDSG5ZYxOF3bJK6UuQTY4CVyfjLO
         3DbH8bknUfZN8gEmd3+qyibCNCssLi8L5aLfXSQk9YNGIfHeHLW3K4TokenwIbN7tckx
         EvwSLufUeYfO6v+EoZO/FJ4FzASbQ3dCGk/SMFLxgdEoicsMglRbLqnKXz0emRKMGEyG
         UcYvtuqhouD0sb7XEoeI0wqNzvvhHRV4OUT4BCE5IDqbBM/5R9R9dHy2LOyqXsy2xDeR
         q+sg==
X-Gm-Message-State: AJIora976JTHm9daSKd4rf2/z8OiDg5MtbHnw0WaMOGRGsfIDwAo3tpf
        IWq9R60L7finv+EggnMZcYOXQw==
X-Google-Smtp-Source: AGRyM1vZ6NSZ6iejW3cP+ma+fW6L3dwMU4IzactuBQcBEgTBGN7rsTMzQU1xDErluCeEX8ueEaVsgQ==
X-Received: by 2002:a05:622a:48d:b0:31e:f1a8:61dc with SMTP id p13-20020a05622a048d00b0031ef1a861dcmr1905138qtx.129.1658126841281;
        Sun, 17 Jul 2022 23:47:21 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id fy19-20020a05622a5a1300b002f936bae288sm2315360qtb.87.2022.07.17.23.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 23:47:20 -0700 (PDT)
Date:   Sun, 17 Jul 2022 23:47:08 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Liam Howlett <liam.howlett@oracle.com>
cc:     Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] maple_tree: Fix sparse reported issues
In-Reply-To: <1098dd4d-8f12-4493-5aff-1ee489d8e7@google.com>
Message-ID: <b8f67958-11cf-2fb2-aba9-6cc88c75874@google.com>
References: <20220712142441.4184969-1-Liam.Howlett@oracle.com> <653cc1da-e45a-9a93-7158-cee3e710ba35@redhat.com> <20220713132926.3sl7gs67dyjj7kit@revolver> <44a478e8-2ccc-e82-bd5a-172778c01529@google.com> <20220713175013.aoemaelds45aavc4@revolver>
 <20220715195301.r7ozt6ph2scti7vz@revolver> <fc9c2193-f5d7-d494-8e4e-c9f340ae8625@google.com> <20220718022718.wtlw7grwp6dv5fcp@revolver> <1098dd4d-8f12-4493-5aff-1ee489d8e7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sun, 17 Jul 2022, Hugh Dickins wrote:
> On Mon, 18 Jul 2022, Liam Howlett wrote:
> > Do you have the patch
> > "maple_tree-Fix-stale-data-copy-in-mas_wr_node_store.patch"? It sounds
> > like your issue fits this fix exactly. I was seeing the same issue with
> > gcc 9.3.1 20200408 and this bug doesn't happen for me now.  The logs
> > you sent also fit the situation. I went through the same exercise
> > (exorcism?) of debugging the various additions and removals of the VMA
> > only to find the issue in the tree itself.  The fix also modified the
> > test code to detect the issue - which was actually hit but not detected
> > in the existing test cases from a live capture of VMA activities.  It is
> > difficult to spot in the tree dump as well.  I am sure I sent this to
> > Andrew as it is included in v11 and did not show up in his diff, but I
> > cannot find it on lore, perhaps I forgot to CC you?  I've attached it
> > here for you in case you missed it.
> 
> Thanks!  No, I never received that patch, nor can I see it on lore
> or marc.info; but I (still) haven't looked at v11, and don't know
> about Andrew's diff.  Anyway, sounds exciting, I'm eager to stop
> writing this mail and get to testing with that in - but please
> let me know whether it's the mas_dead_leaves() or the __vma_adjust()
> mods you attached previously, which you want me to leave out.

I just went ahead with both of those still in, my do_mas_munmap()
non-fix reverted, and your "Fix stale data copy" added: looks very
promising so far, been running two hours without a problem.  I
do expect it to hit the migration entry !PageLocked BUG soon (as
it quickly did on the laptop), but that's okay: I'll switch over
to thinking about that BUG, so long as tonight's run does not
crash in some other way.

Hugh
