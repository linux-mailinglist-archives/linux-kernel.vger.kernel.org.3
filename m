Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7E450F012
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 07:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244252AbiDZFEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 01:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244273AbiDZFEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 01:04:51 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D16FD17EC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 22:01:42 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y14so16123817pfe.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 22:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mkPRDXMojyzY4qLqBJMMJM+l3Q8ZwwRnxZtf0mTrZFA=;
        b=aQPVZqzGp2TnCvBtslKJlyZIttR8ls8LDP9YYSF1m4fZ0pDc0bjVbIpmjp9rP+AZdn
         U9iIGHdJKSUOoooVz5SIoCq+zUJubJbs87F+LOckuSXH2p+0MqKSUnQUkOgz7LeXobKH
         t+2atMqnQMOuBnrccMg6G4LfbFwjBGZtr/WV7KujcJMqb5RTUfAb/gGyp6hofmOeHs6l
         /HLIxmmQtX3Qa6bi67eXdp3qIVlFieMeE5itTr5u+xhRy5p2+EqhVBfa2AfvqPO7KIod
         NwfH7Bt8ekZq3iR5QYId61qf3CDkgt6FF5MZCwQ92Nvqpl38F0yFZiCc7tyqFzcptexH
         xtFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mkPRDXMojyzY4qLqBJMMJM+l3Q8ZwwRnxZtf0mTrZFA=;
        b=YF26uv0uA9ajNPSoXce6dGeKakc8uz853R8RWI6ZlMtmpiZrBQJX3hx/3ilvPlUDIJ
         qpFEUBRzqZ+CTR7teyHuT+7C1zGwRBUluSo8jRM7k39dyI90Hnim38ldS7gRh5glSJcD
         5KcuDH3wVVWpbaFqUV2tfRkqjqu0G86kXAjed8FSf08IFcpWpEFZ3tToCEGPDPTg35iY
         fCrsZd2gaju3UVDfEkE6VCc2Hw4VN4muZkDthHZw24QWm9ssnsCZ4wJsWkuCtDhhxLMr
         D4R2LTMXlTh8Z7szrX+enh8XIb+3XF6EXWNn1Gnf1w3jG3CKap3V96uAY3g3CM5m7Vqo
         PCIw==
X-Gm-Message-State: AOAM5313ibQ5r/ma+d4O7WJag3rKECO6Idsvz/fpkN/qIoDGC+0xmsgd
        ZuuDOhHSQxlobDRRkPalWtdBySLRXDBUkyqmC94rUZamnjo=
X-Google-Smtp-Source: ABdhPJxzYXrzCZ2t/STABZZMXYFwavHW+XUOVpecyOzAXPgcgzH8fq3S7Pz9jPtglltjQh3lmGqj4iOm/BVUYT02Zoc=
X-Received: by 2002:a05:6a00:e14:b0:4fe:3cdb:23f with SMTP id
 bq20-20020a056a000e1400b004fe3cdb023fmr22462013pfb.86.1650949301268; Mon, 25
 Apr 2022 22:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220424062655.3221152-1-ran.jianping@zte.com.cn>
In-Reply-To: <20220424062655.3221152-1-ran.jianping@zte.com.cn>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 25 Apr 2022 22:01:30 -0700
Message-ID: <CAPcyv4gKMM4A4MPo=xm0SP6E_7C-897K6Nfh7_wmdgY7c0gxdw@mail.gmail.com>
Subject: Re: [PATCH] tools/testing/nvdimm: remove unneeded flush_workqueue
To:     cgel.zte@gmail.com
Cc:     Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>, ran.jianping@zte.com.cn,
        Jane Chu <jane.chu@oracle.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 11:27 PM <cgel.zte@gmail.com> wrote:
>
> From: ran jianping <ran.jianping@zte.com.cn>
>
> All work currently pending will be done first by calling destroy_workqueue,
> so there is no need to flush it explicitly.
>

Looks good, applied.
