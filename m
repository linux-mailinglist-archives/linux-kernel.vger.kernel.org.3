Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAC3491E60
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 05:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237852AbiAREF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 23:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbiAREF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 23:05:57 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73623C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 20:05:57 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id l16so12730781pjl.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 20:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=zv9WXqV8vqC3j/zyXrptfmKmy6B6enP0K/hpwWNEgTo=;
        b=l/YtsjnyohEUzENprx/EzUAvSluSpj8rpGpQF+tH7wTn62oMMcRAFbgmVBz44KKaGa
         aMrdD5AP/ZImiXNKrdWtuWu1JV7BZZSkiYazoE5Vv791c+f2doH9J63JdJDZ2nl/vBnh
         LwyZoy9V9KuoJOHKEYzefxfRj2Cl4XOadb9PE5az/1wND8lF7ileLeVV2j3IlFw9Rv6A
         cbAAyf7pprYM7I2Yz+cv3QAv7lutW3pTwAYjlUByz/uM/2l3nJXsRM5Fj2rzQj3RfqUP
         tH6u/Sk7sAc8bb84XcMREx7ZrN+xADNtEREb94ooUCYQwUshzQYhaVb1HfXYKvdD7C6h
         IIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=zv9WXqV8vqC3j/zyXrptfmKmy6B6enP0K/hpwWNEgTo=;
        b=7cePPR6pt7V0q9JbZ8krBB27df+q75ciVBKK75Hd587qm9DyvKsjspHSjM227x6Aoj
         ipLXVS4+I8sEDMiL0KU/4oL7hiRQ+fyCwtUeNNo0qSOvCq+pmyR7xG163TVgqCJTIQwk
         iXiMXAE/Q890nuI1ZXmIq8+65eNTnKE2AawcIRjzlFHDUGeTmMAuV4rY8OP2pr4NrdIY
         2di9Oeq5C7LRMxF4yORdsgsPEp0oYly8yo8mvBBbBLvbV1zPbX8J1xNKZb1E/m6TbOoa
         dkfTbDVsIYhSPQnHKkh7kK16uZLS1CHSiLzvEk27tGrdMftT1IMCnm1R21SMlwLWysiB
         svqg==
X-Gm-Message-State: AOAM532PVrPFWQv1xN7DFRXGUeRCDKvka/qO2CpKXg4+9rSHXZQusoYC
        iQqpaXgjhXQtG7UWPcP5rqhz1cnsDetXW2KSE0Vo1cezbfmzhAYs
X-Google-Smtp-Source: ABdhPJxDftv3+8dC7LYjfqZdiJMnSzy0aGhsctQ+9iX74f0SG+U/x1b6UvsMkoaLvrcSHhcTkTeAAQHl7Zmd4rlABm0=
X-Received: by 2002:a17:902:9f97:b0:14a:b594:7913 with SMTP id
 g23-20020a1709029f9700b0014ab5947913mr9355867plq.111.1642478756862; Mon, 17
 Jan 2022 20:05:56 -0800 (PST)
MIME-Version: 1.0
From:   Eric Lin <eric.lin@sifive.com>
Date:   Tue, 18 Jan 2022 12:05:45 +0800
Message-ID: <CAPqJEFoUyHiyNj8Hx-wRaw86NLb5hGo-WT4ysqV4RGerYyDyJA@mail.gmail.com>
Subject: About perf tool set exclude_guest = 1 on guest environment
To:     linux-kernel@vger.kernel.org, namhyung@kernel.org,
        jolsa@redhat.com, alexander.shishkin@linux.intel.com,
        mark.rutland@arm.com, acme@kernel.org, mingo@redhat.com,
        peterz@infradead.org, yao.jin@linux.intel.com
Cc:     Greentime Hu <greentime.hu@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Currently, I run the perf command 'perf record -e branches:u ls'  and
'perf record -e branches ls'. It will set exclude_guest = 1 as below:

# perf record -e branches:u ls
# perf evlist -v
branches:u: .., exclude_kernel: 1, exclude_hv: 1,, exclude_guest: 1, ..

# perf record -e branches ls
# perf evlist -v
branches: ..., exclude_guest: 1, ...

As I understand it, set exclude_guest =1 will not include guest counting.
May I ask if I run the above commands as a guest user, should the
architecture implementation ignore this exclude_guest flags and still
make perf can count guest events in Linux kernel?

Best regards,
Eric Lin
