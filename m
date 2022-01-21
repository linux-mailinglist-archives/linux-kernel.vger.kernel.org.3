Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1FCB4957A1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 02:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbiAUBIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 20:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbiAUBIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 20:08:20 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA44C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 17:08:20 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id r11so6866304pgr.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 17:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LRoSE7bLhVXoMJDEt2S7sS57wVQZ1ZPwbrkPvObc7cM=;
        b=X47hLxm9qUJ3qGT8pUYPsjz2oNygOeBaTyTl0W+Bgxnl3+mtUtwZOiLElgGU9RuXqL
         oe0hK4DdCDO6LdIxPAUz2qrBCeTpdjKsGvDjWuuw1fw6NnjwSCGZuzUV7H4GgYJYP/T/
         YKFGs+5Rgwb5tNMb29paB5UpKl8AO7eyk85ph18zmwqUAV3+au9XSAH5tQl8fPmL0sf6
         y2+i5ms2rt78RBH2boYZ3UGVL1OYlAm5wmWJ6mwRA1N/0mXuQ2JHe9V2Aj/n2OIz0X6E
         HL3xJwwooeoybtXj+SEndtfI+g2d55fdVajI+HNzJLyFJ+E/vEXBoJaPGGvEGCHvxIpk
         qV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LRoSE7bLhVXoMJDEt2S7sS57wVQZ1ZPwbrkPvObc7cM=;
        b=STX9OlvxONPdl1M5xo2FSSSLPpjU1uolp9lyJ8UySyapQcTBMa8NMercsT36xkym/M
         k21qq5LBCvAlkP+p3C67chZpRpSem8ZoLzJKjzz4zKn1NydT1hOHdYeRILHcYL9wU5T3
         QlvgMv8wWAg433PVqC2FkBWKXBTXO/4xUPGWq1+jyp5uqOj22pYHVkg4FHfPoPQ50rzp
         4KLxdpvvXddbNbv3zePVGKBM5hlfl3amuh0yobOLICaU1UtDAFcvK96+VbdvFB00Ko9x
         G8awplb50SRMkMLA2faHjiczqbbF8AQSnmwDBpr/9DwzVoPn5eGcamZB0i0ZzqjWcJf7
         hOFQ==
X-Gm-Message-State: AOAM531rNcVgm4QxHtdhbWo7doqDDx8SoQPpojIZdr/PR/mDDAHfNqzY
        sUYmtNvzDAbCl8/N717B+tE=
X-Google-Smtp-Source: ABdhPJxcQP+5XLhe+zWwn4W537UZjdwNkYCJB58LhYv+VS4rskzPULS6fB2RTPCu0du+BKDYIyKHpQ==
X-Received: by 2002:a62:3003:0:b0:4c1:6983:f1c3 with SMTP id w3-20020a623003000000b004c16983f1c3mr1372083pfw.20.1642727299487;
        Thu, 20 Jan 2022 17:08:19 -0800 (PST)
Received: from baohua-VirtualBox.localdomain (47-72-151-34.dsl.dyn.ihug.co.nz. [47.72.151.34])
        by smtp.gmail.com with ESMTPSA id j8sm5018838pfc.127.2022.01.20.17.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 17:08:18 -0800 (PST)
From:   Barry Song <21cnbao@gmail.com>
To:     khalid.aziz@oracle.com
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        dave.hansen@linux.intel.com, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longpeng2@huawei.com, rppt@kernel.org, surenb@google.com,
        willy@infradead.org
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
Date:   Fri, 21 Jan 2022 09:08:06 +0800
Message-Id: <20220121010806.5607-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1642526745.git.khalid.aziz@oracle.com>
References: <cover.1642526745.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> A file under /sys/fs/mshare can be opened and read from. A read from
> this file returns two long values - (1) starting address, and (2)
> size of the mshare'd region.
> 
> --
> int mshare_unlink(char *name)
> 
> A shared address range created by mshare() can be destroyed using
> mshare_unlink() which removes the  shared named object. Once all
> processes have unmapped the shared object, the shared address range
> references are de-allocated and destroyed.

> mshare_unlink() returns 0 on success or -1 on error.

I am still struggling with the user scenarios of these new APIs. This patch
supposes multiple processes will have same virtual address for the shared
area? How can this be guaranteed while different processes can map different
stack, heap, libraries, files?

BTW, it seems you have different intention with the below?
Shared page tables during fork[1]
[1] https://lwn.net/Articles/861547/

Thanks
Barry

