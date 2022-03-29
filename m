Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0384EA845
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 09:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbiC2HFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 03:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbiC2HFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:05:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A62BB937;
        Tue, 29 Mar 2022 00:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=du90gsiDlM+40+IbjuJ8V4ICCC4TYDzPGHi3osdAGGw=; b=mAylmWChiSovWT4CCUEtsY4pC4
        ciarHSfwCUcQnkIn87ofQykBFVLFtKOIuBP6jBN16sVFwYNSyZoj3YvWeaESF4RDPQhoTAYi+51SB
        aSmQ5hzJ/Jf7eR08SRzF9er2z5unN2a9mjuPxI0SqMi5fS4D8Pxtxl9WAgDPEslH3MS1Seu2haRFp
        dLNQRiiWubrxmwmAoIOtwgq0oVpr6fCZigNVHzpPZyGUEVNhRbLm2BeqfVt20l8F02W2Mk5+CDhGm
        29XHGI1MpNjArUyqKlo5xLMiPcmm0DCfebs/JyMiCxlenw8b5LFQEDlIanePDZONfkwC7AYVklFw6
        vDjMD9JA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZ5tf-00BGHd-J4; Tue, 29 Mar 2022 07:04:07 +0000
Date:   Tue, 29 Mar 2022 00:04:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com
Subject: Re: [PATCH] scsi: sd: Jump to out_free_index if device_add{,_disk}()
 fail
Message-ID: <YkKvZ1bp0Q5bi2ln@infradead.org>
References: <20220328084452.11479-1-fmdefrancesco@gmail.com>
 <20220328143853.GU3293@kadam>
 <2179817.iZASKD2KPV@leap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2179817.iZASKD2KPV@leap>
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

On Tue, Mar 29, 2022 at 08:18:16AM +0200, Fabio M. De Francesco wrote:
> Yes, correct. I've just looked at how put_device() is implemented. I didn't 
> know how it works until you made me notice. Thanks!
> 
> Aside this I sent another diff to Syzbot. Today, at 4.30 CET, it replied again
> that, after applying and testing my new patch, Syzkaller was not anymore able 
> to trigger the memory leak that it had reported.
> 
> This is the new diff...

Yes, this new diff makes much more sense.

