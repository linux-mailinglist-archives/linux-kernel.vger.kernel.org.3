Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD1E5AA608
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 04:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbiIBCrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 22:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbiIBCr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 22:47:29 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C3DAFAF0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 19:47:26 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id i188-20020a1c3bc5000000b003a7b6ae4eb2so2514792wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 19:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=i0zAjehzydukGxrFbfo8AbAsUA6uk164VmJzS2KuTgs=;
        b=Rv93Z8IELRgt+NurrFxHcSE8nMIQUt6gbHU5L6ZB2WHNo/VMlG8N907WMKEg6rIv91
         uRBVJCYXFC8XaMxgVDms72m8IB0rc+gZnwES0dk7qWYw/egizMHYx5k2dAK96aeXTaMm
         Z9A48gxkYcrnx0s+zycAOWbFoW2hiX6xpMv5GJkprP1Jw7jdzSXgRjfvoo9tqftZAhcl
         pWaS2AiP2WNken9mJ1X5C6RWO8lVLO3WZTgvAcmWzPdgaOTEimr0HBbFFKD4/CP6vPOB
         og84S4ZZIrw56Fa0hRCeFnWvjJ8rUJCZGmPgc5SFKDv1TZDre1Ld02y0TGUuBmef7jok
         v9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=i0zAjehzydukGxrFbfo8AbAsUA6uk164VmJzS2KuTgs=;
        b=kbPD+JDBYIIf1xLkyy8Qhu5vSNK+IrxH+Gi0sqwcvh+BE+PxLA6RYb4ImA0WIaiYhr
         R5SDg9COL9Oy85aya4RHqcMcKDmwIO9JL30eBFMAxBJ4DtYK942Gf+Fk073lg0ERrq6O
         s08CyCth+c4HRmPdZXdVLKg1DVY//k0a4LFHV2ayFJFh0D9rB1tFAImIh5RvDsRbqy8Y
         gdp/oxP9DlE9ymAe2HMr2SmykaCBqA7Tnqs+aIEWNfNodbOlPANtfKWfjkEgK/2Uko3W
         3qbINc6vEpb4GUbYR/oWHe0VT5WFRwuchIcGMWZV05+vaEaZT2A0Joc3PtUYOHOhsK6y
         Qk6A==
X-Gm-Message-State: ACgBeo1eJxu4u5XeuIDSt3+/p3d+QjlVvq3s1dZ8mYM0tc2dkXLGljJ9
        TkExbtvtQmxqc/vjKb5wWR6ukZOra7YlJo0rxmIpJhN30m8y/A==
X-Google-Smtp-Source: AA6agR6O3p8LumV1WydGQ4hOTQ57DuG4f1QttCjQqldiMLHPcBO4zDGikwEAWv3/Y8auGA6Xl2aYzCt05AODFmezgrw=
X-Received: by 2002:a05:600c:254:b0:3a5:a401:a1e2 with SMTP id
 20-20020a05600c025400b003a5a401a1e2mr1136458wmj.14.1662086843712; Thu, 01 Sep
 2022 19:47:23 -0700 (PDT)
MIME-Version: 1.0
From:   Rick Yiu <rickyiu@google.com>
Date:   Fri, 2 Sep 2022 10:46:47 +0800
Message-ID: <CAKns5cVnF6r5074Sq4y0-CXhpkBPXv+Uy8f18ku9d0UOE9iHmw@mail.gmail.com>
Subject: Question about cpuset_hotplug_workfn in kernel/cgoup/cpuset.c
To:     linux-kernel@vger.kernel.org
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

Hi all,

In the commit

deb7aa308ea26 cpuset: reorganize CPU / memory hotplug handling

It states so in the comment for this function:

/*
...
 * Note that CPU offlining during suspend is ignored.  We don't modify
 * cpusets across suspend/resume cycles at all.
 */

However, I did see the function cpuset_hotplug_workfn called in the resume
path, which costs 10+ ms on our platform. I was wondering if the statement
is still true, could this function be bypassed in the resume path?

I also filed a bug for this.
https://bugzilla.kernel.org/show_bug.cgi?id=216321

I wish to be personally CC'ed.

Thanks,
Rick
