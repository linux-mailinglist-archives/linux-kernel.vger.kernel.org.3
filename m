Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26C258CEB6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 21:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbiHHTse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 15:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiHHTs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 15:48:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05AE1DFA3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 12:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659988105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/GndbpOdEsWW3Ey1GFStHOY4x2/TccVmhX9gHCE2e40=;
        b=JlLA8A8wRI5NBNEzep4QtN4NBJNHoTc0tdOTSs0LEiBH8pP4jv2U+PSRN9yOvqZylQoRqz
        frFt05By9AJzIearXbGrJGRmFJMSeG7s5+aYDPQqC9cp/K+RcmzeatXLcTQTPc4OHu9dEK
        DOaMumfe2+vxg5rs5BLeZsWJoT3JN1A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-I3NLYgTqO6OR8QwojzGW5g-1; Mon, 08 Aug 2022 15:48:23 -0400
X-MC-Unique: I3NLYgTqO6OR8QwojzGW5g-1
Received: by mail-wm1-f69.google.com with SMTP id n30-20020a05600c501e00b003a3264465ebso1140wmr.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 12:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=/GndbpOdEsWW3Ey1GFStHOY4x2/TccVmhX9gHCE2e40=;
        b=HYl/NRV+Ao0VGVd/9j2f/a++QMlCf4oi81gQnEd9jcfXriK5wvudYYfRuI8wvpbBpm
         f3ghQicwBpouu+B7bLfNpKoXq/u5DgVScJXyngVVJN1ncctgKtd3vX3nkwnA5XjihC6K
         0OiMw0LGHyHQVF5768Xs1+a0CXa837JCqxQcqlD818eY9c3ze6QxVvo6ykxm3hYWlvWl
         BP9sDh4Jgo2z/IBLYSRpBWwXHJhgnYpq775QPMpCnD5WLz72ZOqxgC4HDU+fS9Chr46Z
         bpj4iXoDvStTE/o0vdcB+1GQuCes4BNzJsa5lgCWRnmKDJ27cZNUQvfDkSUUX5fLEggC
         5D8A==
X-Gm-Message-State: ACgBeo3DclUEqS6A4vH0WVguFIGYTn3M74sgmKi8s7LdMOrDdHk8ec4R
        PY9aFVDCQnO7hjEWY7IR3tIhzXxwxVA6Eq6vOThbF0AIIUeqPsn0QaHb7hTys+YvzhNz5fE47CS
        cUCFFkGwlpvSbls2lkH0pipY=
X-Received: by 2002:a05:6000:178c:b0:222:f8ec:9977 with SMTP id e12-20020a056000178c00b00222f8ec9977mr2529254wrg.509.1659988102503;
        Mon, 08 Aug 2022 12:48:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4wJ7LojV6ap4KmTRyk0CU1xjQumbUrwh2+AS35G9oakKYiRb2GBRHD9y266OQuShj0T3ykkw==
X-Received: by 2002:a05:6000:178c:b0:222:f8ec:9977 with SMTP id e12-20020a056000178c00b00222f8ec9977mr2529246wrg.509.1659988102279;
        Mon, 08 Aug 2022 12:48:22 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id t5-20020adff605000000b0021e5f32ade7sm11911544wrp.68.2022.08.08.12.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 12:48:21 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     frederic@kernel.org, mtosatti@redhat.com
Cc:     cl@linux.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, pauld@redhat.com, neelx@redhat.com,
        oleksandr@natalenko.name, atomlin@atomlin.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v6 0/2] tick/sched: Ensure quiet_vmstat() is called when the idle tick was stopped too
Date:   Mon,  8 Aug 2022 20:48:18 +0100
Message-Id: <20220808194820.676246-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederic and Marcelo,

I have incorporated an idea from Marcelo's patch [1] where a CPU-specific
variable is used to indicate if a vmstat differential/or imbalance is
present for a given CPU. So, at the appropriate time, vmstat processing can
be initiated. The hope is that this particular approach is "cheaper" when
compared to need_update() - used currently; in the context of nohz_full and
the scheduling-clock tick being stopped, we would now with this patch,
check if a CPU-specific vmstat imbalance is present before exiting
user-mode (see tick_nohz_user_enter_prepare()).

This trivial test program [2] was used to determine the somewhat impact
under vanilla and with the proposed changes; mlock(2) and munlock(2) was
used solely to modify vmstat item 'NR_MLOCK'. The following is an average
count of CPU-cycles across the aforementioned system calls and the idle
loop, respectively. I believe these results are negligible:

	  Modified		   |  		Vanilla
                                   |
  cycles per syscall: 7399         | 	cycles per syscall: 4150
  cycles per idle loop: 141048     |	cycles per idle loop: 144730
                                   |


Any feedback would be appreciated. Thanks.

Changes since v5 [3]:

 - Introduced __tick_nohz_user_enter_prepare()
 - Switched to EXPORT_SYMBOL_GPL()

Changes since v4 [4]:

 - Moved vmstat_dirty specific changes into a separate patch
   (Marcelo Tosatti)

Changes since v3 [5]:

 - Used EXPORT_SYMBOL() on tick_nohz_user_enter_prepare()
 - Replaced need_update()
 - Introduced CPU-specific variable namely vmstat_dirty
   and mark_vmstat_dirty()

[1]: https://lore.kernel.org/lkml/20220204173554.763888172@fedora.localdomain/
[2]: https://pastebin.com/8AtzSAuK
[3]: https://lore.kernel.org/lkml/20220801234258.134609-1-atomlin@redhat.com/
[4]: https://lore.kernel.org/lkml/20220621172207.1501641-1-atomlin@redhat.com/
[5]: https://lore.kernel.org/lkml/20220422193647.3808657-1-atomlin@redhat.com/


Aaron Tomlin (2):
  mm/vmstat: Use per cpu variable to track a vmstat discrepancy
  tick/sched: Ensure quiet_vmstat() is called when the idle tick was
    stopped too

 include/linux/tick.h     |  5 +++--
 kernel/time/tick-sched.c | 19 ++++++++++++++++-
 mm/vmstat.c              | 46 +++++++++++++---------------------------
 3 files changed, 36 insertions(+), 34 deletions(-)

-- 
2.37.1

