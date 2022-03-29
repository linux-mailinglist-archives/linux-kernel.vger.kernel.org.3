Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820B74EAF7B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 16:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238033AbiC2Ooi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238037AbiC2Oog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:44:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FA675C01;
        Tue, 29 Mar 2022 07:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pb2mFNdYEDesME+0UYGEnxFM4maT9VaGMvxMtxanb3w=; b=wI6hqwzdGh6ZRRS+fccpwNIUiy
        an80UXeyBI21rRlhvR75P6Gc+ryH35KYr2/AmIdT+qPuTOT+THiTjOme/s5bTbWC04l22InzKTxOR
        pci0uOYYZWMQ+9T2TdOGsxqYW6ThWYWpcdRVtBHPtNWHJQim7w05T8B+jXk2qxRi7kyyRBWLdAySy
        9KHdZGVVtYu0650w3rCP+6JydvyMPVWYxSYt/kLf4LARAnpOWf4TsqS9T39M+aTil+Bo8KYwH0JN7
        0skZkhL7BwqG7gplarv2P4mtZTda4Fp5lcZA93u44zqGTeqxxnL0w9Cw8Cu3El5z02d3JKeg0lwlU
        KIqxkpzA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZD3Z-00CWVC-UV; Tue, 29 Mar 2022 14:42:49 +0000
Date:   Tue, 29 Mar 2022 07:42:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Yu Kuai <yukuai3@huawei.com>,
        andriy.shevchenko@linux.intel.com, john.garry@huawei.com,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH -next RFC 2/6] block: refactor to split bio thoroughly
Message-ID: <YkMa6eIkXqok2QPq@infradead.org>
References: <20220329094048.2107094-1-yukuai3@huawei.com>
 <20220329094048.2107094-3-yukuai3@huawei.com>
 <YkMKgwsZ3K8dRVbX@infradead.org>
 <e46db33f-84a6-6d23-9be2-7429fec71046@kernel.dk>
 <YkMabVKr+7Mg53E1@infradead.org>
 <338207c2-e3cd-abc1-6b8c-f08645ef144a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <338207c2-e3cd-abc1-6b8c-f08645ef144a@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 08:41:57AM -0600, Jens Axboe wrote:
> Fixing fairness for wakeups seems useful, however.

Agreed.
