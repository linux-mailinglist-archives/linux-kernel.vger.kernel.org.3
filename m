Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0038A5A4BBF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiH2M1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiH2M0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:26:42 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3B191D1A;
        Mon, 29 Aug 2022 05:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661775027; x=1693311027;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=oxQnpIC7Es3fbk5Y7KL1o+zPbw4eWKeljrhF6pZeVsU=;
  b=c9n04zJXK+ylVyxhfduX1T3vms3s2gxOxI0408bWObExuazE+SAa2Jg3
   FFwzXdnNAlhynWoe7iGgJQ12tMKPG3+h4zCdiV+6u9HPR9nlofpBSEDge
   /kvUtoVRPLSn4QrAePZMy4IKsfuuTuF+Z4yMSZDiFrhGAumz8FT8IChR8
   PFDAZphQrY7wBjQEzDxjHt7mOtp3ZMXlteIqRDCCBZBiuEY9BcArQ553I
   ImrvBevAP+JL5HNgWY2FoG9RQkQaZk8iI9nJYjfvkswQh5v+RQ5YMl04x
   rJLwI0aBos8nIyNiCNkItqNTLTZ2F1/Qj6C2mhhOSCTOEMuk8iefO3ENA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="294886252"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="294886252"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 05:09:15 -0700
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="588142891"
Received: from kvehmane-mobl1.ger.corp.intel.com ([10.251.220.41])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 05:09:08 -0700
Date:   Mon, 29 Aug 2022 15:09:09 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: Re: [PATCH 3/3] serial: Add kserial_rs485 to avoid wasted space due
 to .padding
In-Reply-To: <CAHp75Vc4NfZE6DxFnfeAS9fxnZHpxMjacHy1TsG8ib+FiCqFLQ@mail.gmail.com>
Message-ID: <1712a4c5-638-4e63-af29-32bdcbaab443@linux.intel.com>
References: <20220826144629.11507-1-ilpo.jarvinen@linux.intel.com> <20220826144629.11507-4-ilpo.jarvinen@linux.intel.com> <CAHp75Vc4NfZE6DxFnfeAS9fxnZHpxMjacHy1TsG8ib+FiCqFLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-174262208-1661774957=:1928"
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-174262208-1661774957=:1928
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 26 Aug 2022, Andy Shevchenko wrote:

> On Fri, Aug 26, 2022 at 5:51 PM Ilpo Järvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> 
> > -static int user_rs485_to_kernel_serial_rs485(struct serial_rs485 *rs485,
> > +static int user_rs485_to_kernel_serial_rs485(struct kserial_rs485 *rs485,
> >                                              const struct serial_rs485 __user *rs485_user)
> >  {
> > -       if (copy_from_user(rs485, rs485_user, sizeof(*rs485)))
> > +       struct serial_rs485 rs485_uapi;
> > +
> > +       if (copy_from_user(&rs485_uapi, rs485_user, sizeof(*rs485)))
> >                 return -EFAULT;
> 
> > +       *rs485 = *((struct kserial_rs485 *)&rs485_uapi);
> 
> So with all assets we have we can be sure that on BE64 / BE32 machines
> this will be flawless. Is this assumption correct?

I think so. At worst it could trigger a build fail assuming the kernel 
would do some really odd struct layout reordering (which, according to 
the build bot, doesn't occur for any currently tested arch).

Now that you highlighted this line though, I started to wonder if it would 
be just better to use memcpy() instead as it would avoid those casts.

> > + * padding.
> > + */
> > +struct kserial_rs485 {
> > +       __u32   flags;                  /* RS485 feature flags */
> > +       __u32   delay_rts_before_send;  /* Delay before send (milliseconds) */
> > +       __u32   delay_rts_after_send;   /* Delay after send (milliseconds) */
> > +       struct {
> > +               __u8    addr_recv;
> > +               __u8    addr_dest;
> > +       };
> 
> Btw, can't we convert them to kernel doc?

Yes, why not.

-- 
 i.

--8323329-174262208-1661774957=:1928--
