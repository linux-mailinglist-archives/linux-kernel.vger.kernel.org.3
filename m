Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE915AEFCE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238522AbiIFQC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbiIFQCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:02:07 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BE392F44;
        Tue,  6 Sep 2022 08:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662477735; x=1694013735;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pvrR9AaLZeSwwdJMT20ILWHfqE4EnXxLAynRB+jX/wQ=;
  b=Um8gNvqCvUVyx8LaKk16gyE6h8lS6nQ7vGfMfL0UD0FBVyU/oMurtOlr
   QAiMwMq7Mm6Da8SmBKQmU9Y74lkA9RrpTKboCyLYf/0las1kh59hM0u0N
   18NozXJRxTQ3GiQtrPE+FtOFdV8GWP9oes4yuZVuaMpfvfWsEPLfIuZf7
   MEEDBTtvuzk17MvnzjE0zVsbXYq1CMOv8ym4LBhP5Ts5Hf4MXIelCB1sk
   1vYaqIVbIVodGKyn1NVtG/HHnd5fgHnWB6kENpI8QV23RipOr2VywMmwm
   qRKYVdQ6ejLrmDL+TXtolWBmtZlOCHF0jPM65miwngnBlQi7TsSk38pY6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="297405550"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="297405550"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 08:22:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="675734200"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 06 Sep 2022 08:22:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 5BF0586; Tue,  6 Sep 2022 18:22:27 +0300 (EEST)
Date:   Tue, 6 Sep 2022 18:22:27 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, sanju.mehta@amd.com,
        mario.limonciello@amd.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Resume PCIe bridges after switch is found
 on AMD USB4 controller
Message-ID: <Yxdls5XlZ0EBGfON@black.fi.intel.com>
References: <20220905065622.1573811-1-kai.heng.feng@canonical.com>
 <YxWgGKIAvsxwSz85@black.fi.intel.com>
 <CAAd53p4iV=ne5bDGZ6FxE9bBUVoFh=eXF9_oMPvPzjVj=UVoog@mail.gmail.com>
 <YxWqSYDWe0NitSkL@black.fi.intel.com>
 <CAAd53p6bSmTPavjA0v6tybc6=HrwiDn0JGzXwVOG_m5EVw1p1w@mail.gmail.com>
 <YxYXH5dqKqPANeVX@black.fi.intel.com>
 <CAAd53p5tYG=mAR-RSr1g_iznmmcCy1QpthG5vQzr99AP4QLJyg@mail.gmail.com>
 <YxdNKx1OFKsgBUBu@black.fi.intel.com>
 <CAAd53p6nNh1nUSfJgj5db+2B=eOCfiKta5aRiGsE4N0teL9cPQ@mail.gmail.com>
 <YxdgZavuLU78lqIL@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxdgZavuLU78lqIL@black.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 05:59:49PM +0300, Mika Westerberg wrote:
> This reminded me that in Intel hardware there is an ACPI power resource that is
> shared between related devices. IIRC there is _PR0() method under the root
> port, xHCI and the TBT NHI that returns the same power resource. Now, when the
> power resource is turned on for any of the devices the kernel wakes up the rest
> too to make sure they get properly re-initialized if they went into
> D0unitialized or something like that. The commit that added this is
> 4533771c1e53 ("ACPI / PM: Introduce concept of a _PR0 dependent device").

Probably has nothing to do with this actually.
