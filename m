Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D775707E0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 18:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiGKQF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 12:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiGKQF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:05:26 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50F963917;
        Mon, 11 Jul 2022 09:05:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1657555508; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=fi/+0YUi0Z1XGGnmtEao17Apcl4A+D+M7Eydzr4zaECKEJpQisd0+9aIOOqN7QU9cgZ+4JJnonhLQ1uWoUA24kHLwvbAYRisRW913fRC0ILnPkyxiI/f1OS9Vv1pcOp7AXAZscu/2OKxI91+xIDx1oLRk0c1g9O1UrK+yjHspNo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1657555508; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=CKrQS05Osf0cYASc3hvSa3UVP4bEQHmeALMpF7CZxQQ=; 
        b=VxOl3mihwIOWQFhQgGR1N14Wbdji7wa8FeJH688fxsDk4bgVbjDXfLoi9QOKA07EgiYioaMOlYTQNWDVDhN/ILDfvBVu/55Q+bnAzUSSVtjSLEBAwtkpWOaJw5Z9qWEykZkQPXj3r8cpYSMx1JTzvTmcxomPa+Ly6FWs2U1DiwE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1657555508;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=CKrQS05Osf0cYASc3hvSa3UVP4bEQHmeALMpF7CZxQQ=;
        b=cmkffHp2Jh79+rcjxrfdlnvQjipTWcShDP8ygrMzX5Y5vmgS0aKnnVbgEN4OUHEP
        TYOm3RmqiBT4bTZGNLuOnh+zxR5rdt8uEQcNiZOsx53X3qwHPq2hRXtMwK88SKK37ta
        ZTK2YCVpDjf29+laj3cRJsILx51wi7HmFZgELlRg=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1657555506079247.95644078579937; Mon, 11 Jul 2022 09:05:06 -0700 (PDT)
Date:   Tue, 12 Jul 2022 00:05:06 +0800
From:   Li Chen <me@linux.beauty>
To:     "Christoph Hellwig" <hch@infradead.org>
Cc:     "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Frank Rowand" <frowand.list@gmail.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "linux-arm-kernel" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "devicetree" <devicetree@vger.kernel.org>,
        "linux-mm" <linux-mm@kvack.org>
Message-ID: <181ee01d384.b809bd01412268.496620746959082770@linux.beauty>
In-Reply-To: <Ysw7TMFO8Mw0nq8x@infradead.org>
References: <20220711122459.13773-1-me@linux.beauty> <Ysw7TMFO8Mw0nq8x@infradead.org>
Subject: Re: [PATCH 0/4] add struct page and Direct I/O support to reserved
 memory
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_RED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,
 ---- On Mon, 11 Jul 2022 23:01:32 +0800  Christoph Hellwig <hch@infradead.org> wrote --- 
 > Who is going to use it and how?  Because normally the reserved memory
 > is used through the DMA allocator, and you can't just do direct I/O
 > to that.
 > 

My use case has been stated in the cover letter, but our driver is not ready for upstream yet.

With DMA allocator, we can access buffer in kernel space, not userspace, however, this patch
series servers for userspace direct I/O, so that you can mmap device file as src buffer from userspace,
and dio to file on disk.


There are some mmap + rmem cases in the kernel source tree which don't use the DMA allocator already.

I also found some users have asked for a solution of supporting direct I/O on file_operation->mmap like:
https://stackoverflow.com/questions/44820740/using-o-direct-with-io-memory
https://www.mail-archive.com/support-list@support.elphel.com/msg02314.html

I believe there are some other potential users who didn't post questions on the internet.

If the upstream kernel has this feature, these users can mmap their
reserved memory to userspace and get direct i/o support.

Regards,
Li
