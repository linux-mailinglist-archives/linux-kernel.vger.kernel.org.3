Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101A052F824
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 05:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354480AbiEUDuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 23:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiEUDuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 23:50:16 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65238187DB4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 20:50:15 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso9314133pjg.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 20:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1thg0gD9LkoJN152HkT0OTmkJzX4+vIrjo7MEWofe+w=;
        b=jo+qEFyNr7yZv2BLra+Du20hufyMVTOka43o6y0X1kCVL+qxdrbSb5wGRDLDcy2mIC
         QKiAYZ0hDQOUN8R1P7p9IrIv0f8K8ABeeWf2kbJxnPoD9wUZYXXYODjWq6E3yzztuTCP
         fb3gCYiMvrJMqdFuPG+bzQHnbx++aq0T3HQB2VTzc2ClYYftzifKCX2hK6aX+iWrzYnh
         CEYyGv22r8ctZ6Dfk15ecRT9apCGJNWpiNjfTT3L2OJq+IR7EdVaau5CFLkBT8XmkSV4
         pKnHnIKhCno5XvopZ4/Y12x6tzcUXnUVAmtpu97+601e7uTHdM8OOCSYK9HkuFiF4v6+
         dSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1thg0gD9LkoJN152HkT0OTmkJzX4+vIrjo7MEWofe+w=;
        b=4Yvljn+soJ1zTXDSTRJtUKCv0EiAxK0Lt6Erb1eC6jIPfI89I7KPSn2t47HorXiSoP
         7hwOOu9AEedsk6lahCoBn8jCKBMwCU1mZdhFFbwCM4+z5nShaEEpvHy+f5OGwojJmVd+
         lunmmL0fYAlRFVgb9ser5vVmme7hPNaZmLXJZ24aIov6FAxLzyVM2RLm3NgbQJWAkunM
         HN//Eo8qXZXoit4hjQcmrIFcfVx9aTEMzjA8DGBzKocS5XW9dqzFQLi7LwpyuSwwE+4z
         4x1VyABNm9uSaknjFDdC1fPmlJsB9Jtd6fwK4Ri3CfNaDA9tD6SHYiR05+ONYftaAniT
         u0bA==
X-Gm-Message-State: AOAM5313QyIe/3/Ns6eXcOXNtaSEQo7UZO+U4reXKu/uskG0UBrxiDea
        7VlBHUEkC6aKWgH8MXwX7Qs=
X-Google-Smtp-Source: ABdhPJwrmcJWaI5Mv2ARLKgUuuvw86bgEuR9UlPJEFOvrpvfOBAMVgMH/2LtnJltOwaKfoPbKAFROQ==
X-Received: by 2002:a17:902:f647:b0:161:67af:6bf0 with SMTP id m7-20020a170902f64700b0016167af6bf0mr12093832plg.100.1653105014641;
        Fri, 20 May 2022 20:50:14 -0700 (PDT)
Received: from strix-laptop (2001-b011-20e0-15d4-84b3-8c62-a0b8-199e.dynamic-ip6.hinet.net. [2001:b011:20e0:15d4:84b3:8c62:a0b8:199e])
        by smtp.gmail.com with ESMTPSA id z15-20020a170903018f00b0015e8d4eb2easm445903plg.308.2022.05.20.20.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 20:50:14 -0700 (PDT)
Date:   Sat, 21 May 2022 11:50:06 +0800
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Suren Baghdasaryan <surenb@google.com>,
        Colin Cross <ccross@google.com>,
        Feng Tang <feng.tang@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mike Rapoport <rppt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Daniel Axtens <dja@axtens.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        David Hildenbrand <david@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kaiyang Zhao <zhao776@purdue.edu>,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Jim Huang <jserv.tw@gmail.com>
Subject: Re: [RFC PATCH 2/6] mm: clone3: Add CLONE_COW_PGTABLE flag
Message-ID: <20220521035006.GB1506735@strix-laptop>
References: <20220519183127.3909598-1-shiyn.lin@gmail.com>
 <20220519183127.3909598-3-shiyn.lin@gmail.com>
 <7cb4c588-7a24-8557-6cd6-3ec59051c2b1@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7cb4c588-7a24-8557-6cd6-3ec59051c2b1@csgroup.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 02:13:25PM +0000, Christophe Leroy wrote:
> 
> 
> Le 19/05/2022 à 20:31, Chih-En Lin a écrit :
> > Add CLONE_COW_PGTABLE flag to support clone3() system call to enable the
> > Copy-On-Write (COW) mechanism on the page table.
> 
> Is that really something we want the user to decide ? Isn't it an 
> internal stuff that should be transparent for users ?
> 
> As far as I know, there is no way today to decide whether you want COW 
> or not for main memory. Why should there be a choice for the COW of page 
> tables ?

Agree.
It should not expose to the user.
COW of page table should become the configuration.
Or, if the change is fine, it can even be the default setting.

Thanks.

---

Sorry I did not group reply the first time.
