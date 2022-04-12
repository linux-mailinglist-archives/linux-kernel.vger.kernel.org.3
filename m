Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FAB4FCEF3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 07:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348150AbiDLF2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 01:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346902AbiDLF2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 01:28:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AAE34B81;
        Mon, 11 Apr 2022 22:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qKT+rKxJxRTHwUX6zSPidvw6TsQOrmd//JseePK15uA=; b=hafi3HcZO8eclGRtpUfrnE7sz+
        GnBAtjQIZNL0tYtwdHuTZcGGXIpJdnbezVWLvAEmIgpr/gr+rzKToHd/w0XwyrBFB5p/FWfb5+Ej6
        JapzhsrEoapweCNZ5h4r3Dj3E+4PlafjaTJX0J0B+Tbx8yOAREaPPKadIanLPk+Ffiv3116nxwEt5
        g+pFhD6zKyBrqNfguDK1LNiQuOIgAk0e9zJwd547O7NmObUXW1eYNLsngge5e/VM0SQfM/KA3cLq7
        Jp4gRfd3Lkbi13GGMT3PSYNozHQoB5nUKtOJyn194Qmr9eP8ztXnRQEiGYg/O1GNm4aQXxnGUS5vZ
        uODATKMA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ne922-00BmCM-4j; Tue, 12 Apr 2022 05:25:38 +0000
Date:   Mon, 11 Apr 2022 22:25:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, tim@cyberelk.net,
        axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com,
        nathan@kernel.org, ndesaulniers@google.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] security: do not leak information in ioctl
Message-ID: <YlUNUgTfej6VpkWS@infradead.org>
References: <20220409145137.67592-1-trix@redhat.com>
 <YlREKRb/xgAFsi97@infradead.org>
 <eec2efee-1153-8d8e-77c2-96156733a0c6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eec2efee-1153-8d8e-77c2-96156733a0c6@redhat.com>
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

On Mon, Apr 11, 2022 at 09:31:20AM -0700, Tom Rix wrote:
> The failure can happen in the transfer loop, so some of the data will not be
> zero.
> 
> And checking status should be done.
> 
> zero-ing is because i am paranoid.

Maybe I'm just lost because of all the reformating.  Please do a first
patch that split the CDROMREADTOCHDR and CDROMREADTOCENTRY into one
helper each and the just do the minimal fix on top so that it is
reviewable.
