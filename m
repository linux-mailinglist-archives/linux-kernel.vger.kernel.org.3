Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD844BF302
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiBVIAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiBVIAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:00:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0993A14891A;
        Tue, 22 Feb 2022 00:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zmbM9xjZv/x2PiLgbnsox7WqEPCLtKRX3L96LPROHEc=; b=0jxxZRczjnnzihX6kbVsgO87eE
        SZxfmJs8QwG38+tFxI1rdj1aF3a5ieXydLebaTKrzXHxlXj14UkIWnv0Hr1x6G19hz2X/CDAeMvkY
        kFilE3Zo8D9B8W+cBVrKUTS22fi71l0ufBRzzSl7BeUCdHQdY+UzoYZlv+9Hyy/z2BJeez/HfkZM+
        AG0CzCtZXRXIkiymb9VjVxGc65MxVAJm9ABtqilEr+0ZOzsgOtahaip9fns9HB/x7EcoWpEDjzv3Z
        1R6Eppp5eQUHMiD64zR+NJsiLHlu0dZyiRaozwZUU1uK2/eM9FjvG4mcPIg0VtQ+UK5juOVUgNSpK
        abv//ITg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMQ5k-008Qf8-W0; Tue, 22 Feb 2022 08:00:12 +0000
Date:   Tue, 22 Feb 2022 00:00:12 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     "Juergen E. Fischer" <fischer@norbit.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aha152x: Clean up struct scsi_pointer usage
Message-ID: <YhSYDC4YMEx0XCYY@infradead.org>
References: <4e17ff7295a96e31ed21ccb250c65b56c173b530.1645484982.git.fthain@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e17ff7295a96e31ed21ccb250c65b56c173b530.1645484982.git.fthain@linux-m68k.org>
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

On Tue, Feb 22, 2022 at 10:09:42AM +1100, Finn Thain wrote:
> Bring aha152x into line with 10 other drivers which assign
> scsi_host_template.cmd_size = sizeof(struct scsi_pointer)
> and avoid the "struct foo { struct bar; };" silliness.
> 
> Remove a pointless scsi_pointer->have_data_in assignment.

I think this going in the wrong direction.  The scsi_pointer should
go away entirelym and the fields actually used by the driver should move
into the aha152x_cmd_priv structure instead.

Same for all other drivers still using the scsi_pointer.
