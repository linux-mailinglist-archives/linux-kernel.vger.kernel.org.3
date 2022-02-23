Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DB24C0C8A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 07:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238339AbiBWGbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 01:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbiBWGbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 01:31:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EF060ABB;
        Tue, 22 Feb 2022 22:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Mym/h6YpZsFXh7+iKk8DwnZ9xaixR3q5K6YNYz/TNd4=; b=D3XA1T3Qe9IXl2DQ4wiKeSO5E9
        O6Liu2jVV6RzN4A+mt3yfQ7krek8XnrYPid/TkgwGoMg1S6gL+tGRqYY9tozwfEqsrgV+OqByxvWf
        cpQ2ed8ei/HkApN0o7vHFpJwvIy4oNd1eLMICW8twW1g6PhPEIX20vUsX2WrTSFwjqXKKtX8fl2MB
        LkE7Kw9cDHXKVO6ia9dsjkBlzmCDBD2qEL+LmHj+2l1D6DOBh4XCYy2woFM2WmeZ6zFAvxCHG/50o
        oAdOyBKsDORvALn9GYpt86AsEsqYomPv0hnrmxY77H93uKgSzIW8kvZvaTYp6ZEOJNYDMqU9r5q5B
        pxTSH6vA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMlAf-00Cz1Y-7c; Wed, 23 Feb 2022 06:30:41 +0000
Date:   Tue, 22 Feb 2022 22:30:41 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Juergen E. Fischer" <fischer@norbit.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aha152x: Clean up struct scsi_pointer usage
Message-ID: <YhXUkRSsOUyOZkm4@infradead.org>
References: <4e17ff7295a96e31ed21ccb250c65b56c173b530.1645484982.git.fthain@linux-m68k.org>
 <YhSYDC4YMEx0XCYY@infradead.org>
 <62241a-be3-ed61-965f-afec1452f2c4@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62241a-be3-ed61-965f-afec1452f2c4@linux-m68k.org>
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

On Wed, Feb 23, 2022 at 10:08:08AM +1100, Finn Thain wrote:
> Are you asking me to rework Bart's series? Or are you asking Martin to 
> drop it, or both, or neither...

Neither.  Either leave the as-far as I can tell harmless inconsistency
as-is, or if you want to fix it up send a patch that removes the usage
of scsi_pointer in aha152x entirely by adding the actually used members
to the private structure.
