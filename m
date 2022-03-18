Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C174DDABA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 14:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236760AbiCRNm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 09:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236759AbiCRNmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 09:42:50 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655E31EF5C8;
        Fri, 18 Mar 2022 06:41:31 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="343572245"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="343572245"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 06:41:31 -0700
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="517211696"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 06:41:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1nVCqW-002Fg5-A9;
        Fri, 18 Mar 2022 15:40:48 +0200
Date:   Fri, 18 Mar 2022 15:40:47 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] serial: 8250: Add proper clock handling for
 OxSemi PCIe devices
Message-ID: <YjSL34DkktVVahmy@smile.fi.intel.com>
References: <alpine.DEB.2.21.2106260539240.37803@angie.orcam.me.uk>
 <alpine.DEB.2.21.2106260604540.37803@angie.orcam.me.uk>
 <YOyi0cPdIVSCcpmw@surfacebook.localdomain>
 <alpine.DEB.2.21.2107130150420.9461@angie.orcam.me.uk>
 <CAHp75VfnCG-C6bUzhhC9jQGOSgMXVLZ=QtH0mdhAD85yeqBC7A@mail.gmail.com>
 <alpine.DEB.2.21.2107131504270.9461@angie.orcam.me.uk>
 <CAHp75VeS3UdK5o4cEKuT=nz+Yob9FBv6RNJ-i116pFZQTGuyuQ@mail.gmail.com>
 <alpine.DEB.2.21.2202052213110.34636@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2202052213110.34636@angie.orcam.me.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2022 at 08:41:19AM +0000, Maciej W. Rozycki wrote:
> On Mon, 19 Jul 2021, Andy Shevchenko wrote:
> 
> > >  The TIOCGSERIAL/TIOCSSERIAL ioctls.  It's not clear to me why you're
> > > asking; as a serial driver expert you must have been surely aware of their
> > > existence.
> > 
> > Yes, I know how it's used. It's the ugliest hack in the serial support in Linux.
> > Telling that baud rate is 38400 and supplying something completely different,
> > non-standard stuff.
> 
>  Well, the interface reflects how hardware used to work actually.
> 
>  My DECstation 5000/200 box has an ASIC providing a quad UART, or a serial
> line multiplexer really (handled by drivers/tty/serial/dz.c BTW), which is 
> a design dating back to 1970 and a discrete DZ11 interface for Unibus[1], 
> and the device has a 4-bit baud rate selector for the internal generator 
> with individual settings from 0x0 to 0xe selecting the standard baud rates 
> between 50 and 9600 baud, and then 0xf selects an external baud generator 
> input, which in this particular machine lets you switch between 19200 and 
> 38400 through a board CSR.  See how this arrangement exactly matches the 
> EXTA/EXTB macros aka B19200/B38400 (now you have found out where these 
> have come from!).
> 
>  The original DZ11 interface did not expect such high serial communication 
> speeds of course and hence the shortage of control bits for the internal 
> baud rate generator.
> 
>  And then the SPD_CUST API has been similarly invented for an analogous 
> shortcoming of the old version of the terminal I/O interface (who could 
> have thought speeds beyond 38400 would ever be required!) and we continue 
> carrying this historical baggage, as the cost of backwards compatibility.
> 
>  Note that the DECstation 5000/200 is a 1990 design, so not much older
> than Linux and we just adapted to the world at the time.  I wouldn't mind 
> a saner API to set the raw clock divider, but nobody has come up with a 
> more up-to-date solution.

What do you mean by the last sentence? The BOTHER is exactly what is new
ABI for the baud rate setting without using any ugly hacks in the kernel.

> > >  You can program the divider registers directly with any bit pattern
> > > supported by hardware.
> > 
> > And again, how does it differ from BOTHER paths (except being a hack)?
> > You supply baud rate with 1 baud granularity and program hardware
> > registers accordingly. (Yes, I remember you pointed out the sub-HZ
> > frequencies, but I don't buy it as a very good argument because the
> > only significant error can be achieved at baud rates under the 100).
> 
>  With this device owing to the internal 16-bit divisor range limitation 
> you can't even set the baud rates under 100 (or under 239 actually) with 
> BOTHER.  This has nothing to do with HZ; it's just that 15625000 / 65535 
> works out at 238.422.

I'm lost here. BOTHER requests whatever user wants to have with 1 baud
granularity. How can't it work? The only limitations here are the hw
limitations, but it doesn't affect the kernel <--> user space interfaces.

>  Plus all the world is not modems and teletypes nowadays anymore.  People 
> wire all kinds of weird equipment to serial ports and the more flexibility 
> we give them in driving it the better.
> 
> > >  You don't know what use for it has been out there
> > > in the field for the last ~30 years.
> > 
> > Is it a question or statement?
> 
>  It's a statement.

Use of SPD_CUST? Yeah, this weirdness may have spread a lot, but some of the
commits in the Linux kernel suggests that SPD_CUST is discouraged to be used.

> > > > > 3. it doesn't hurt.
> > > >
> > > > It hurts development a lot.
> > >
> > >  It is there and the presence or absence of the feature for OxSemi devices
> > > does not affect anything but OxSemi support code.
> > 
> > It's a pity. But what support code needs the SPD_CUST nowadays?
> 
>  I don't know.  But there is no alternative raw interface and I think it 
> is important to give people good tools for their work.

BOTHER _is_ the one. It seems to me you never tried it.

> > >  It is currently a supported feature for OxSemi devices (and most if not
> > > all 8250 derivatives), and I don't see a reason to selectively remove it
> > > with this specifice submission.  There may be installations out there that
> > > rely on it -- there have been shortcomings in the implementation, which
> > > are the motivation for this patch series, but mind that we've had support
> > > for OxSemi Tornado devices since 2008.  That's a lot of time.
> > >
> > >  Driver writers for other UART implementations may choose to have it or
> > > not to with their new code written from scratch.  As a matter of interest
> > > I've checked zs.c, one of the serial hw drivers I had considerable input
> > > to and it uses its own ZS_BPS_TO_BRG macro rather than `uart_get_divisor',
> > > so it does not support this feature (and dz.c only has a set of 15 fixed
> > > baud rates, which is where the original termio B<rate> macro bit patterns,
> > > as well as the EXTA and EXTB macros for the externally supplied clock
> > > chosen by the 16th bit pattern, come from).
> > >
> > >  And as I say: if you want to remove it, then do it globally and tell
> > > people that as from Linux x.y.z this feature is no longer supported, so
> > > that is clear and unambiguos and some poor IT soul out there does not get
> > > hit by a random obscure driver feature removal with a kernel upgrade.
> > 
> > I had had this in my plans [2] but suddenly I had no time to accomplish 
> > it. :-(
> 
>  So I do hope you can realise why perfect is the enemy of good enough.  

I hope you can realise that as well. Because BOTHER is already supported and
what you are doing is uglification of the code and resurrecting an evil.

> There was nothing wrong in particular with my proposed bug fix for the 
> clock calculation and yet half a year on and we got nowhere only because 
> my proposal was not perfect enough and then I was preempted with other 
> stuff.

> > >  NB in the course of this effort I've learnt the hard way that `setserial'
> > > is even invoked automatically nowadays in startup/shutdown scripts for
> > > port state saving and restoration, so a random unannounced feature removal
> > > here can wreak havoc with people's installations they have configured
> > > years ago.
> > 
> > I believe that for these years spd_cust shouldn't be used at all. OK,
> > it seems the first thing we may do is to patch the user space to give
> > a fat warning that spd_cust is deprecated and should be avoided.
> > And... it seems already there [3].
> 
>  Yet no equally functional alternative.  Call it BRAW or something and 
> pass a 32-bit or 64-bit cookie for the driver to interpret.  And then you 
> can remove the spd_cust/38400bps hack.

Have you tried BOTHER? It's already there for a long time. Don't tell me that
it's not an equivalent. It's better than that.

> > >  Just pointing out the incompleteness of the implementation should
> > > SPD_CUST be removed.
> > >
> > > > So, please no, drop it.
> > >
> > >  Based on my consideration given above, no, I maintain keeping the feature
> > > is the right approach, at least for this change concerned.  After all its
> > > purpose is to correct baud rate setting and not to remove vaguely related
> > > features.
> > 
> > I see your point. My question here, does this series extend SPD_CUST
> > to additional (newly supported?) baud rates? If so, I would be against
> > that extension. Supporting deprecated stuff is okay for a while.
> 
>  It does allow one to program the full clock divider range of the OxSemi 
> devices.  I find it appropriate according to my engineer's code of good 
> practices.  And it doesn't cause any burden for non-OxSemi code.

How BOTHER does prevent you doing the same?

> > To the end of the discussion may be good to read also these [4] and [5]
> 
>  Thank you for the pointers, however there's nothing new to me there, 
> sorry.
> 
> > >  Not for serial hardware drivers, but a while ago I committed what now
> > > lives at Documentation/networking/device_drivers/fddi/defza.rst along with
> > > several other networking driver notes, so I imagine we can have a similar
> > > collection for 8250 stuff and the like.
> > 
> > To me any folder is more or less okayish as long as it's there, under
> > the Documentation :-)
> 
>  I've chosen Documentation/tty/device_drivers/oxsemi-tornado.rst then, 
> following the pattern.
> 
> > >  OK, the size argument alone makes some sense to me, though OTOH splitting
> > > sources into many files prevents the compiler from doing interprocedural
> > > optimisations, which can only be partially compensated by LTO (if enabled
> > > in the first place).
> > >
> > >  I'll see what I can do here anyway.  Mind that non-PCIe OxSemi stuff
> > > remains incomplete, as I noted above, so it'll be a partial driver anyway.
> > 
> > Thanks for doing that anyway!
> 
>  So I have had a look at how it has been done for other drivers and I have 
> now convinced myself against such a split.  The primary reason for this 
> conclusion is that there is no basic infrastructure for such a split and 
> the ultimate result is code duplication with no clear benefit to justify 
> it.

Justification for split is to keep certain quirks out of the scope of the
generic driver. I'm not sure what duplication you are talking about if the
LOC statistics shows otherwise.

>  Take for example the most recently separated dedicated 8250_pericom.c 
> driver: its `pericom8250_probe' function duplicates pieces extracted from 
> `pciserial_init_one' (so if a change has to be applied to either function, 
> then all its siblings have to be manually verified as to whether the same 
> change has to be applied there as well; I bet that it won't happen as 
> required and pieces of code will slowly diverge and suffer from bitrot) 
> and then PCI error handling and suspend/remove support have been removed 
> for no reason.

You may not want to get the idea, it's fine. The rationale is simple:
isolate quirks for certain platform(s) in one place. Each platform
in a separate module.

>  I suppose common code could be factored out from `pciserial_init_one' and 
> the other routines private to 8250_pci.c either moved to a library archive 
> to be linked into individual drivers or to a subdriver along the lines of 
> drivers/net/ethernet/amd/7990.c or drivers/scsi/esp_scsi.c.  But it is not 
> the case at the moment, so in my opinion the split has been premature.
> 
>  Originally I thought that those separated drivers are merely a source 
> code split across multiple files to make maintenance easier, all to be 
> built and linked together under the SERIAL_8250_PCI option, rather than 
> standalone drivers.  It is clearly not the case though.
> 
> > >  I'll repost the outstanding pieces of the series with the adjustments I
> > > have agreed to make.
> > 
> > Thanks!
> 
>  I shall be posting v3 right away along with fixes for serveral issues I 
> have come across in the course of this development.  I will be happy to 
> address any bugs, functional issues or coding style problems that may have 
> escaped my attention, however I consider this version otherwise final and 
> I am not going to make this code a separate driver or remove the custom 
> baud rate divisor support code.
> 
>  The rationale behind this is that AFAIK it is not the Linux kernel policy 
> for any of its subsystems to require any other bugs or missing features to 
> be addressed as a prerequisite for a bug fix or even a functional 
> improvement to be accepted.
> 
>  If this remains unacceptable, then so be it.  I have already gone above 
> and beyond with this submission and I have put enough time into it, and I 
> am not going to invest anymore, as this is likely to exceed what long-term 
> maintenance as a local patch is going to take on one hand, and the change 
> has been published so people who might need it can chase it and install 
> locally themselves.  This is not my pet project, but rather an ad hoc 
> effort to fix issues I have come across by chance.
> 
> References:
> 
> [1] "DZ11 asynchronous serial line interface", 
>     <https://gunkies.org/wiki/DZ11_asynchronous_serial_line_interface>
> 
>   Maciej

-- 
With Best Regards,
Andy Shevchenko


