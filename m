Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F365A2930
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 16:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiHZORE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 10:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiHZORC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 10:17:02 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1493D84EFD;
        Fri, 26 Aug 2022 07:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661523421; x=1693059421;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=kTrD8XVumNsQznaAxkisCeG/ZK5CPIUgT+cNViwlSKE=;
  b=BarSOXXQzUqwkfcSR7sqeosy+T9lJnXABI+/ArbrshHUiGvFK46niThK
   VUzds/Td8KrGIqF4xFWETzSQpJ/EkZarkBHSG2lSIOufsGQJQNp17JJtB
   JIsl9bFkvFhFatoXbS/Rxhxd9S08zNdS8pOKMMVFpv98zzaYxCd2Jr7QD
   a9E8ML/IF8jM8fMCIjlkJ4q6DKZzTM7W6KuU4JZYtFhRnqVWNCYBc5Szn
   ewhDPhhvlFg94vVeMxjbW3z4siHOQ3plovc23PO6MtjbDXX+/tv1xkxpA
   Ip3sWbOLMtzWJ6fLm9gYMFdcV4lb7WbsL2/TLN9m9F3oEbn46YjKSmRjH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="274266918"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="274266918"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 07:17:00 -0700
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="640070814"
Received: from syeghiay-mobl.ger.corp.intel.com ([10.252.41.100])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 07:16:58 -0700
Date:   Fri, 26 Aug 2022 17:16:50 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] serial: dz: xmit buffer is UART_XMIT_SIZE'd
In-Reply-To: <alpine.DEB.2.21.2208261419080.26998@angie.orcam.me.uk>
Message-ID: <c950e8c1-f2f-a4a2-5863-19685925a514@linux.intel.com>
References: <20220825131746.21257-1-ilpo.jarvinen@linux.intel.com> <20220825131746.21257-2-ilpo.jarvinen@linux.intel.com> <alpine.DEB.2.21.2208261419080.26998@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1036785657-1661521528=:1606"
Content-ID: <159da0f7-1ca-c051-b282-43c126e61a89@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1036785657-1661521528=:1606
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <ff82e224-27f6-acf1-36a5-e83a1746272c@linux.intel.com>

On Fri, 26 Aug 2022, Maciej W. Rozycki wrote:

> On Thu, 25 Aug 2022, Ilpo Järvinen wrote:
> 
> > In theory, the Tx code would be buggy if UART_XMIT_SIZE differs from
> > 4096 (occurs when PAGE_SIZE > 4k), however, given the lack of issue
> > reports such configuration likely doesn't occur with any real platform
> > with dz HW. The inconsisted sizes would cause missing characters and
> > never-ending bogus Tx when ->head reaches the region above 4k. The
> > issue, if it would be real, would predate git days.
> 
>  This is misleading.  There are exactly 3 machine models (2 major ones and 
> 1 extra submodel) that we currently support which make use of this serial 
> port hardware and driver, and they all have their R2000/R3000 MIPS CPU 
> soldered onto their respective mainboards.  And the CPUs they use all have 
> their page size hardwired to 4KiB, so it's not the lack of reports, but a 
> firm assertion that this driver as it stands shall never be used with a 
> different page size.

Ah, sorry. I misread your original statement to contain a question to me 
rather than just you stating a fact.

>  There exists an option card using a DZ11-compatible chipset that can be 
> used with systems we currently support with page sizes of up to 64KiB, but 
> to the best of my knowledge only a number of prototype cards has been made 
> and I have heard of exactly one person having such a card.  Therefore we 
> do not support it and may never do, so it is not a concern for the driver 
> as it stands and shall not be mentioned.
> 
>  Please just state then that the change is for design consistency with the 
> serial core and redefine DZ_XMIT_SIZE in terms of UART_XMIT_SIZE as I 
> suggested for v1.

You had a small error in your suggestion for v1 though (which confused me
somewhat as there obviously was an error in it and I guessed wrong what 
you meant):

>> Also I'd rather:
>>
>>#define DZ_WAKEUP_CHARS      UART_XMIT_SIZE

...I guess with that you actually meant doing simply (and nothing else):

#define DW_XMIT_SIZE UART_XMIT_SIZE

?

But whatever. That line 1/2 is touching is anyway going to die pretty soon
if the 2nd part (yet to be submitted) of the uart_xmit_advance() series 
(1st part here [1]) gets applied so I don't care too much what the 
xmit->tail line will be in between.

I just thought it would have been nice to also get rid of what clearly 
appears to be just a duplicated define of something core already has.

> I'll ack such a change.  Please drop 2/2 at this stage 
> as it does not fix any bug and does not appear to add any value to this 
> driver.

Ok.

I personally don't see the connection between *WAKEUP_CHARS and circular 
buffer size would be strong enough to warrant defining former using the 
latter. ...If it would be there, the other drivers would have a similar 
construct. But I can leave it as is, no significant harm done.

Thanks a lot for your feedback and insight!

[1] https://lore.kernel.org/linux-serial/20220825091707.8112-1-ilpo.jarvinen@linux.intel.com/T/#t

-- 
 i.
--8323329-1036785657-1661521528=:1606--
