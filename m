Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFC5587485
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 01:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbiHAXnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 19:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbiHAXnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 19:43:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A3EB3F32A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 16:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659397382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jfqNi+DY8PkwtU2AAu87TXHxJiOE1cjOeONbpekhqHU=;
        b=DlffhG7k57FrZYDv70wypzydql+bXPH/GTQDOevyhISg85H0see43iPs4dfhQS+5rzv/DE
        ZcG+QODf0tGIpOkbHrPgK94jku5edsE74+1ULU5Vz/JZJGf38VtdRyRq1ZO47PAKpv6beP
        FDMHLicZTR0lmgHPl5qqRz/gDv5Mru0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-214-YhmwgAPjNe6ab8sGBYWeSg-1; Mon, 01 Aug 2022 19:43:01 -0400
X-MC-Unique: YhmwgAPjNe6ab8sGBYWeSg-1
Received: by mail-wm1-f69.google.com with SMTP id r10-20020a05600c284a00b003a2ff6c9d6aso8751953wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 16:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=jfqNi+DY8PkwtU2AAu87TXHxJiOE1cjOeONbpekhqHU=;
        b=I3tCIqgi7WD/U3+5pwQvLRbDCakYHZFOYCWbR/fVr0zb4Eeh6ubHRqJRgHAmsLXYK5
         PKg2dmPC/bzwaL9dCSfPaZBZjmRoKky2ue9Pghc8a82VF043aZC7LNjx0ApfhICJ4f2i
         u1Xqitjj/LZE/YrFd+W3JLDwWD7hCpWz265+q9K9bkJflwVbZLzoFVUKQCZQG+fheDK2
         RU9sWY/6Bdgl5ZR4Ohu12eEBWovxDyOFRSFQaDU4um+5uU7TaCzrv+3kQVxYa5eDL5BF
         AJp5RBJKX/NBUmd+Ep76yZ9Ro/bf3EUgBm66ZF19ABJ6/BwpJPjlLYPlFJ57LeprDddT
         gPcg==
X-Gm-Message-State: ACgBeo2Dxg9MuXfwlBkR7Wb/jfEFDrfO49+BNHiEWr4dJihRTjQvWfmy
        s2SxDs1d2IZQLceqE9z/K448Xm/RCZN01RYgu2ZvfKo64ebeQPIim/Qq1Ky1X7K5uG45uNKnnsu
        Pv9af+3JchSvyCz6JDDdTM78=
X-Received: by 2002:a05:6000:1883:b0:205:c0cb:33c6 with SMTP id a3-20020a056000188300b00205c0cb33c6mr12098323wri.39.1659397380501;
        Mon, 01 Aug 2022 16:43:00 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7O2Blv6a5d+fZUpDwHl4b6r+O4Z+ZYMVadmiJlLS0twAx4POCD1EP9wSqa2Ty2SEcZST+jpg==
X-Received: by 2002:a05:6000:1883:b0:205:c0cb:33c6 with SMTP id a3-20020a056000188300b00205c0cb33c6mr12098304wri.39.1659397380249;
        Mon, 01 Aug 2022 16:43:00 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id i18-20020a1c5412000000b003a4c6e67f01sm7887488wmb.6.2022.08.01.16.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 16:42:59 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     frederic@kernel.org, mtosatti@redhat.com
Cc:     cl@linux.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, pauld@redhat.com, neelx@redhat.com,
        oleksandr@natalenko.name, atomlin@atomlin.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v5 0/2] tick/sched: Ensure quiet_vmstat() is called when the idle tick was stopped too
Date:   Tue,  2 Aug 2022 00:42:56 +0100
Message-Id: <20220801234258.134609-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Changes since v4 [3]:

 - Moved vmstat_dirty specific changes into a separate patch
   (Marcelo Tosatti)

Changes since v3 [4]:

 - Used EXPORT_SYMBOL() on tick_nohz_user_enter_prepare()
 - Replaced need_update()
 - Introduced CPU-specific variable namely vmstat_dirty
   and mark_vmstat_dirty()

[1]: https://lore.kernel.org/lkml/20220204173554.763888172@fedora.localdomain/
[2]: https://pastebin.com/8AtzSAuK
[3]: https://lore.kernel.org/lkml/20220621172207.1501641-1-atomlin@redhat.com/
[4]: https://lore.kernel.org/lkml/20220422193647.3808657-1-atomlin@redhat.com/


Aaron Tomlin (2):
  mm/vmstat: Use per cpu variable to track a vmstat discrepancy
  tick/sched: Ensure quiet_vmstat() is called when the idle tick was
    stopped too

 include/linux/tick.h     |  9 ++------
 kernel/time/tick-sched.c | 19 ++++++++++++++++-
 mm/vmstat.c              | 46 +++++++++++++---------------------------
 3 files changed, 35 insertions(+), 39 deletions(-)

-- 
2.37.1

