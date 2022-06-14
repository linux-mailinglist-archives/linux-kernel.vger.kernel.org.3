Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7149654AC37
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355861AbiFNImh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353729AbiFNImI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:42:08 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE9442ECD;
        Tue, 14 Jun 2022 01:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655196111; x=1686732111;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=sTFaVrkqoKJ+RPXYHxWrHGVjnxcIndtOcGxPl0yyczw=;
  b=lKtbDuvGYd5JXcBnLMpgWmRHG8rK6FOV1YiWr4YiCEzDSvdLQcp8hxW8
   dtuzf6tbiM5AXcMy4ZWcke41Q5sPEPZoSkq8cZRnErPTUXobpHs/0tj3b
   G9jSms7xme40dl2BcDY92D9sR+Xjw9IlX7xR67BVNXBxIkDHwkxWtGO1U
   F0CL18j9Yc7ApooYXD8+PbeLzaATd1VS2Vmp+LGNPzgVuNwPSlr5KVprU
   3v/RLDCEQjDElynm7rIrBnB9Aq7PzbbYp3Yavl7PJXWGckkWHkYWlcMC1
   mV0L60rAFpuzGt0A+54Q09DNuETAQ7pr0ZAH6jGNqYpvxkZ3GaTU+Nr1u
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="364889284"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="364889284"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 01:41:46 -0700
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="910883959"
Received: from jlaghzal-mobl1.ger.corp.intel.com ([10.252.32.175])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 01:41:45 -0700
Date:   Tue, 14 Jun 2022 11:41:43 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/7] tty/vt: consolemap: remove dflt reset from
 con_do_clear_unimap()
In-Reply-To: <20220614075713.32767-7-jslaby@suse.cz>
Message-ID: <baaff049-cb36-9468-3b53-2b7d14441d@linux.intel.com>
References: <20220614075713.32767-1-jslaby@suse.cz> <20220614075713.32767-7-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-49823128-1655196080=:1605"
Content-ID: <77e94118-9dfb-c78e-4492-c4d9fa02cfd@linux.intel.com>
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-49823128-1655196080=:1605
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <b7fe41f8-bfb-d422-6c6d-769d52f9eec9@linux.intel.com>

On Tue, 14 Jun 2022, Jiri Slaby wrote:

> con_do_clear_unimap() sets dflt to NULL and then calls
> con_release_unimap() which does the very same as the first thing. So
> remove the former as it is apparently superfluous.
> 
> Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

...to all patches in this series that weren't individually replied to.

-- 
 i.
--8323329-49823128-1655196080=:1605--
