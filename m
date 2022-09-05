Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A145AD6A2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238996AbiIEPgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238930AbiIEPgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:36:18 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ED64055C;
        Mon,  5 Sep 2022 08:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662392177; x=1693928177;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WhUNghi/IiZ0aS9sedOc5de6KPGY/YFtu9yZreNVi54=;
  b=RNv70RiMcI6n7bgW7cvN5uJi5tRvDJY2lhuGRYIuik4iBWANjHq0ho6m
   mIBPl3ijkguA2oaPTLMgmATo/OlAF+MRlYJx1XI0fVvKlfkKDvjrdDlY5
   id3iluJ+6Kzkpd82Qc3g9VfpQwLscW/gBTNdFdIUokkAL82H3NRlzz9i+
   J94R4rgU6Uls7x/4MXNjE/6DFWAVr1EodjbYxDIUN723RbrCjkzDmdtCU
   YmqIN+sNy60wWhctoZC+cpJF/BxtpAFv4YJMauuI/c72N5Q/gPsl/Hovi
   v3VRRIteAsMtNH7nn0zNBe7IRvOgc9kvL/sEAFFZCbsxGXvrBmOrAD4Q4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="293997725"
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="293997725"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 08:36:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="616443041"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 05 Sep 2022 08:36:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id E8D1114F; Mon,  5 Sep 2022 18:36:30 +0300 (EEST)
Date:   Mon, 5 Sep 2022 18:36:30 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, sanju.mehta@amd.com,
        mario.limonciello@amd.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Resume PCIe bridges after switch is found
 on AMD USB4 controller
Message-ID: <YxYXfhCCaj6tGAx7@black.fi.intel.com>
References: <20220905065622.1573811-1-kai.heng.feng@canonical.com>
 <YxWgGKIAvsxwSz85@black.fi.intel.com>
 <CAAd53p4iV=ne5bDGZ6FxE9bBUVoFh=eXF9_oMPvPzjVj=UVoog@mail.gmail.com>
 <YxWqSYDWe0NitSkL@black.fi.intel.com>
 <YxX3JeQLbciJ+hhc@black.fi.intel.com>
 <CAAd53p5hjmPgPNifo-QV9KU4DFbvPnrYV-YD2b6cSXNN=5GLWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p5hjmPgPNifo-QV9KU4DFbvPnrYV-YD2b6cSXNN=5GLWQ@mail.gmail.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 11:24:26PM +0800, Kai-Heng Feng wrote:
> > can you check if that is happening? It should show up in the dmesg when
> > CONFIG_PCI_DEBUG=y but I don't see it in yours.
> 
> That's because there isn't any child device yet, so the function bails early:
> if (!dev->subordinate || list_empty(&dev->subordinate->devices))

Ah, of course I forgot that this is hotplug case so there are no need
for the delays :/
