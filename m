Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4D757577E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 00:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241051AbiGNWQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 18:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbiGNWQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 18:16:41 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE394F65D;
        Thu, 14 Jul 2022 15:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657837000; x=1689373000;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=mVQwO9QEzd5OsYdGTYrC/Ah0nwY6fA94AdPAZzAXcbU=;
  b=I+79d2cA+gvQesOsgc2UbqGsVc2XKEKxXr/ZpyRG1sarSzcdGyd1S/ql
   KuSQYepiHFjfMxtxR44rXF68zIIWBa8O7PnEfH9yNYeitgHsS3Ir8latf
   prNUZUqnU8QAyLQIvprihtI8mpUWdPnTEF8QCz9eC3wWRRB1ca3zWmTnG
   0bm2Uv3CUjgOPR9ZPB1dglIWTY8PWolESm1o4uClQxnv5PuuLt95S5WZ+
   oUFPpno9jEkkAb6a4+TSJg5J8l54e8yBwWcUvKDp8tNvSqi9PT3AcK5ZD
   tgUnzBpOJz5qr9lsQnMglcNaS0R9d5W7+AHy1OizWfxL1LSzBxD/ijwVj
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="311299492"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="311299492"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 15:16:39 -0700
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="722880444"
Received: from kputtann-mobl1.amr.corp.intel.com ([10.212.211.20])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 15:16:39 -0700
Message-ID: <472f7fc2d44d781edb64f19f9970fe50eec79c1f.camel@linux.intel.com>
Subject: Re: PNP0501 serial driver takes almost 2 seconds to suspend/resume
 (printk issue)
From:   Todd Brandt <todd.e.brandt@linux.intel.com>
Reply-To: todd.e.brandt@linux.intel.com
To:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>, rafael.j.wysocki@intel.com,
        len.brown@intel.com
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Thu, 14 Jul 2022 15:16:39 -0700
In-Reply-To: <875yk0908j.fsf@jogness.linutronix.de>
References: <12fb98fe27e23e3f74a139e5e8eb83a97a343372.camel@linux.intel.com>
         <51b9e2cc3baf61a604bd239b736ec2d12f1f6695.camel@linux.intel.com>
         <87czegxccb.fsf@jogness.linutronix.de>
         <045ebee30af2b80aaeace1dab18ecd113e3f17c7.camel@linux.intel.com>
         <87tu7qvx1q.fsf@jogness.linutronix.de>
         <CAHp75VfyzMNMO2NRwXwSjAmQqBbdRG3+SzyFDG+90dmvmg1xLQ@mail.gmail.com>
         <87o7xwbuoy.fsf@jogness.linutronix.de> <Ysvbp8vz7R9hDNqx@alley>
         <Ysv3JNs4RwE7kAou@google.com> <87ilo1wdac.fsf@jogness.linutronix.de>
         <c60f5634e8605cb4c2ef4646b6e511e6135bea48.camel@linux.intel.com>
         <7d79e9877d63cdb74144f38d8736959281b562cc.camel@linux.intel.com>
         <875yk0908j.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-07-13 at 23:28 +0206, John Ogness wrote:
> On 2022-07-13, Todd Brandt <todd.e.brandt@linux.intel.com> wrote:
> > URGENT: Removing the commit FIXES the issue.
> >=20
> > I just ran a 5.19.0-rc6 kernel with the offending commit removed
> > and
> > it fixed the problem completely on all 3 machines.
>=20
> I believe to have found the issue. A patch was posted to bugzilla:
>=20
> https://bugzilla.kernel.org/attachment.cgi?id=3D301413
>=20
> Please test this. Thanks.
>=20
> John Ogness

I ran with your fix on 30 systems. On the 7 machines where this problem
appears, the patch fixes it completely. On the 23 machines where this
problem does not appear, there are no issues or regressions.

Fix verified, thank you!
