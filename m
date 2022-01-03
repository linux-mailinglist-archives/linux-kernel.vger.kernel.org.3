Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB073483830
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 22:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiACVGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 16:06:18 -0500
Received: from angie.orcam.me.uk ([78.133.224.34]:38466 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiACVGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 16:06:17 -0500
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 521E792009C; Mon,  3 Jan 2022 22:06:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 42D6E92009B;
        Mon,  3 Jan 2022 21:06:15 +0000 (GMT)
Date:   Mon, 3 Jan 2022 21:06:15 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Douglas Gilbert <dgilbert@interlog.com>
cc:     Khalid Aziz <khalid@gonehiking.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Nix <nix@esperi.org.uk>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] scsi: Set allocation length to 255 for ATA
 Information VPD page
In-Reply-To: <d9eaa1f8-7abb-645b-d624-5069205c6983@interlog.com>
Message-ID: <alpine.DEB.2.21.2201032017290.56863@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2201020010540.56863@angie.orcam.me.uk> <alpine.DEB.2.21.2201020030130.56863@angie.orcam.me.uk> <d9eaa1f8-7abb-645b-d624-5069205c6983@interlog.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Jan 2022, Douglas Gilbert wrote:

> > Originally it was thought that Areca hardware may have issues with a
> > valid allocation length supplied for a VPD inquiry, however older SCSI
> > standard revisions[1] consider 255 the maximum length allowed and what
> > has later become the high order byte is considered reserved and must be
> > zero with the INQUIRY command.  Therefore it was unnecessary to reduce
> > the amount of data requested from 512 as far down as to 64, arbitrarily
> > chosen, and 255 would as well do.
> 
> Not arbitrary, 64 bytes would get all the fields less the 512 byte ATA
> DEVICE IDENTIFY data field.

 That may well be the case, however there is no justification given for 
the particular size of 64 bytes chosen either in the comment nearby or the 
change description associated with the commit referred this arrangement 
has originated from.  At the time of my original submission I examined the 
relevant thread of discussion[1] including the patch submission itself[2], 
and just to be sure I have double-checked it now and there is no mention 
as to why this value was chosen.  There is no associated macro that could 
give some explanation and which good coding style would expect rather than 
a magic number inline.

 So I do have all the reasons to conclude this value has indeed been 
arbitrarily chosen, don't I?

> > With commit b3ae8780b429 ("[SCSI] Add EVPD page 0x83 and 0x80 to sysfs")
> > we have since got the SCSI_VPD_PG_LEN macro, so use that instead.
> > 
> > References:
> > 
> > [1] "Information technology - Small Computer System Interface - 2",
> >      WORKING DRAFT, X3T9.2, Project 375D, Revision 10L, 7-SEP-93, Section
> >      8.2.5 "INQUIRY command", pp.104-108
> 
> Yes, 1992, long withdrawn and only used by several billion USB keys.

 Well, this has surfaced in a setup where devices dated 199x are used, so 
I guess they have all the rights to use whatever standard was most recent, 
or say second most recent at the time as we need to factor in design lead 
times.

> How does your problem arise? Could USB mass storage be involved?

 This command does crash the HBA involved where 1/3 and 2/3 have not been 
applied.  No USB involved, just these proper SCSI (SPI) targets:

scsi 0:0:0:0: Direct-Access     IBM      DDYS-T18350M     SA5A PQ: 0 ANSI: 3
scsi 0:0:1:0: Direct-Access     SEAGATE  ST336607LW       0006 PQ: 0 ANSI: 3
scsi 0:0:5:0: Direct-Access     IOMEGA   ZIP 100          E.08 PQ: 0 ANSI: 2

as noted with 1/3 and 2/3.

 Not noted here as not directly relevant though, and this is because this 
change is a clean-up only, to have the buffer size consistent across the 
various `scsi_get_vpd_page' calls, by using the SCSI_VPD_PG_LEN macro 
defined meanwhile, that sets the maximum supported by older SCSI standard 
revisions (which can therefore be safely used without asking the device 
how much data it can/wants to actually return) and consequently devices 
implementing them.

 I noted in the original submission[3]:

> Nix,
> 
> I can see you're still around.  Would you therefore please be so kind
> as to verify this change with your Areca hardware if you still have it?
> 
> It looks to me like you were thinking in the right direction with:
> <https://lore.kernel.org/linux-scsi/87vc3nuipg.fsf@spindle.srvr.nix/>.
> Sadly nobody seemed to have paid attention to your observation and neither
> were different buffer sizes considered (or at least it wasn't mentioned in
> the discussion).
> 
>  Maciej

-- and Nix was kind enough to verify my proposal works just fine with the 
piece of hardware the commit referred addressed a problem with, so the 
replacement buffer size is as good as the original one while making code 
consistent.  As you can see I did observe right away that the buffer size 
was not discussed.

 If you insist that the value of 64 stay, then please come up with a 
suitable macro name to define along with SCSI_VPD_PG_LEN that reflects the 
meaning of 64 in this context and I'll be happy to update 3/3 accordingly, 
but please explain why the value of 64 is any better than 255 here and the 
inconsistency with the buffer size justified.

> And this patch solves your problem by returning part of the ATA DEVICE
> IDENTIFY data (which is 512 bytes long)? If so, why not say so.

 As I noted above, this is for consistency with other `scsi_get_vpd_page' 
calls and to avoid an inline magic number.  If you think that it is not 
stated clearly enough in my change description and the change is otherwise 
acceptable, then I can update the explanation accordingly.

> And what about using 0x2ff as the INQUIRY allocation length? If the
> broken device ignores the top byte, you get 255 bytes back. If a
> correct device takes both bytes it should return 0x23c bytes after
> resid is taken into account.

 I have verified (some of) the devices listed above to correctly reject 
`scsi_get_vpd_page' requests with allocation length exceeding 255, as 
required by the SCSI standard revision at their time.  I can't speak of 
the INQUIRY command, as I haven't checked it in this context.

 Does my explanation clear your concerns?  If so, then please advise how 
to proceed with this change.  Thank you for your review.

References:

[1] "3.10.2 or 3.10.3: arcmsr failure at bootup / early userspace 
    transition", 
    <https://lore.kernel.org/linux-scsi/87r4ehfzhf.fsf@spindle.srvr.nix/>

[2] "scsi disk: Use its own buffer for the vpd request", 
    <https://lore.kernel.org/linux-scsi/51FA71E2.6010501@fastmail.fm/>

[3] "scsi: Set allocation length to 255 for ATA Information VPD page", 
    <https://lore.kernel.org/linux-scsi/alpine.DEB.2.21.2104141306130.44318@angie.orcam.me.uk/>

  Maciej
