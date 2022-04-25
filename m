Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B361C50DAC0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbiDYICI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiDYIBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:01:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275D027CE8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bk7N8VtSWAvLQd3yMexQM6sFuFonXwjn/dFWlACLuw4=; b=KrNUg6E9jRh6S9p23phIwDD+A9
        2yjbvoiMW3hXguiVED3XGeLI5RAp9z3c3rmBxo0F++ml3YQ8tcOKSZOhMELY6kv+Bo4zE7qjAcWtU
        4e1Lurbi4qCxDhsiGkas5y6uhLAsCknOpNVtA8OPhC29Rp4ibbQQWk7Dx2gUkzdJLCazkHqGz7Izp
        3JA0+CRtthmVp/yKRShz0BN0MuqCJ6vXAbzrTgeGDRw/XkPuzBc6ZO2k7jO4uF8Mglc5aF6PsTyYT
        WrTKukboCsRrzIBFPXxbH/jQ1NFzu8tuncjK13ASp0sXfOTrrMx8nRWkxEyq52l9iDKiiOEFi2QRD
        o9WfNkjA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nitc6-008hbI-PT; Mon, 25 Apr 2022 07:58:30 +0000
Date:   Mon, 25 Apr 2022 00:58:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     Oleksandr <olekstysh@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH V1 3/6] xen/virtio: Add option to restrict memory access
 under Xen
Message-ID: <YmZUpua3hkCPdbfx@infradead.org>
References: <1650646263-22047-1-git-send-email-olekstysh@gmail.com>
 <1650646263-22047-4-git-send-email-olekstysh@gmail.com>
 <YmQsFb36UEH9BUnN@infradead.org>
 <6c5042fe-dafc-eb4f-c1fa-03b0faf252de@gmail.com>
 <abc5d23d-3d38-d198-4646-e886df2e83d4@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abc5d23d-3d38-d198-4646-e886df2e83d4@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 09:47:49AM +0200, Juergen Gross wrote:
> > Would the Xen specific bits fit into Confidential Computing Platform
> > checks? I will let Juergen/Boris comment on this.
> 
> I don't think cc_platform_has would be correct here. Xen certainly
> provides more isolation between guests and dom0, but "Confidential
> Computing" is basically orthogonal to that feature.

The point of cc_platform_has is to remove all these open code checks.
If a Xen hypervisor / dom0 can't access arbitrary guest memory for
virtual I/O and we need special APIs for that it certainly false
into the scope of cc_platform_has, even if the confientiality is
rather limited.
