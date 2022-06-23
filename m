Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E001755734F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 08:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiFWGt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 02:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiFWGtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 02:49:21 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74926433B9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 23:49:21 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so1659827pjz.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 23:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S1fyHa70JkLtE4GHnmTbNMD4W38+6M9GgANQzLLFq3g=;
        b=UfjIeJv5kOOWH61E5IDLUm0vSQC2NeXCV4F8abz8hqNeUa2Iq1nYQ3IhoNiVsq0Qz7
         BOeAzY15Q0cgi+RewHEYv/JnVUtXYPUizUXepjm+VTGwtGyIz87JwSuymsR55/523tIp
         MqnWygrcKn3KvWWP1qf13uDxd3Lv2rijwvm60XIgXT88m8a6ZV3nY6GIYq4mfYWbMlhu
         Odk6BuMf3+MRu6lArKS2u+TSoAtgfe4arpgj5ejejxAfBhQAszWXGadgZoAhm/1QGn/T
         dqWOtPAQstQdfQGoHDxZUCFUaq4MdgUx5rcDmG7VUlUkbg9l+yebyn9hqV6FzCE8Dt+u
         XC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S1fyHa70JkLtE4GHnmTbNMD4W38+6M9GgANQzLLFq3g=;
        b=my+CGfNv1lEQEGhjVIvmRM1zm1nFDPBFglHHKQLk/IFSBrRyLXvqfMFxxDiTEqBr9W
         WYuM9Rt743dcvpHYnZBr9T9TWrHbIubbxY6LuLhoEWeTXPHKrsIJkSqa1ewmi7mGsjG3
         Rwzltt2OBP5wsSKz+8NzVvckpMFGww1qfjRcvIbQJ+tXlfaLN4vmGf4csGD6QBRactB0
         ONZZpJEP6TWxecbsKDLz53QT3wSaEEoWANXIACYaVbv9tO3NHK8IMdcpTkQi2vesu5xn
         3Tzng3jNzshIIkGn4G4GsICxRWCXndGZkHpPCuwP21v5+fQZcjDaoEclBh7OFjEhLAE+
         07VA==
X-Gm-Message-State: AJIora+YaXsSv3/4ct0Qd1J1vPPWbJ1okrq1iBYDHEmKcX6sLxWl41wv
        NBbyQ+Rw5XetiRWtzY5nRfv++g==
X-Google-Smtp-Source: AGRyM1vwrj0yETxMeiv/acqm4R/rKtRnfOsNjEhq7dy+YwMfywnecQWLuB+2OOWmcD5bd+ak4k94Ew==
X-Received: by 2002:a17:90a:c782:b0:1ec:eea2:4236 with SMTP id gn2-20020a17090ac78200b001eceea24236mr2434470pjb.20.1655966960923;
        Wed, 22 Jun 2022 23:49:20 -0700 (PDT)
Received: from localhost ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id f6-20020a170902684600b0015e8d4eb1f9sm11535199pln.67.2022.06.22.23.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 23:49:20 -0700 (PDT)
Date:   Thu, 23 Jun 2022 14:49:16 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, shy828301@gmail.com,
        willy@infradead.org, zokeefe@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/16] mm/huge_memory: use helper macro __ATTR_RW
Message-ID: <YrQM7Kr/XgE09dEd@FVFYT0MHHV2J.usts.net>
References: <20220622170627.19786-1-linmiaohe@huawei.com>
 <20220622170627.19786-9-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622170627.19786-9-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 01:06:19AM +0800, Miaohe Lin wrote:
> Use helper macro __ATTR_RW to define use_zero_page_attr, defrag_attr and
> enabled_attr to make code more clear. Minor readability improvement.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
