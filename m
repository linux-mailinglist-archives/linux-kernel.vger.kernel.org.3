Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA0649F099
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 02:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345122AbiA1BgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 20:36:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57468 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236055AbiA1BgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 20:36:03 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20RNa4v1024390;
        Fri, 28 Jan 2022 01:36:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=AVZ5ibpU3o0fyTi6IejMZZ1yK9yc3izd0IBnwgt0Kf4=;
 b=j+bZr5D9mN/iRUmawtpnGBFOyhPuIPn/bMnwnAT7umTJVhdLkZxWI9TJW/l6F/dfo2db
 wc2nkvdqH/zFSLFHd7Hbl1pCQg1V25UCU86K265NYDuj9Tbf+yqD96+RYhTaNcIbo+/Z
 qXco+B1NZf86qcPmfjCbNX0as8lEaSch0XuUK2GKbwFu2VJjxR1F/gjjbU8SS/EBj60u
 JUYirPyMQUJ8JucN2qagfWI+CJS/4BwEgg4zWPxYD45fp7Z/QtH6QqA9bIMi0saWqnc3
 fkPgtFHibpbt8Ui7gREQW322285HD0fAy8wULHvGt8KhYBXXi9x4NbLDxW5xWZwnHxiQ oA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dv41vtr4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 01:36:03 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20S1OnWp010921;
        Fri, 28 Jan 2022 01:36:03 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dv41vtr40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 01:36:02 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20S1MoEA026491;
        Fri, 28 Jan 2022 01:36:00 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3dr9j9w8ad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 01:36:00 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20S1Zu2H33096096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 01:35:57 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCC9AA4040;
        Fri, 28 Jan 2022 01:35:56 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51B67A4053;
        Fri, 28 Jan 2022 01:35:56 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.77.44])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 28 Jan 2022 01:35:56 +0000 (GMT)
Date:   Fri, 28 Jan 2022 02:35:53 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org, Jason Herne <jjherne@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH] s390: vfio-ap: Register the vfio_ap module for the
 "ap" parent bus
Message-ID: <20220128023553.56a8b135.pasic@linux.ibm.com>
In-Reply-To: <75637be1-7459-1cdc-3b4d-f8f3225f7b8b@linux.ibm.com>
References: <20211201141110.94636-1-thuth@redhat.com>
        <8512bb0a-a34a-09b0-65f3-781f3d092364@linux.ibm.com>
        <87k0g8scx1.fsf@redhat.com>
        <1eb9ca5c-b1bb-b768-64ee-e4a1b31bb171@linux.ibm.com>
        <6aaf6c60-a258-29e3-fcec-82c77d3945a4@redhat.com>
        <87tufaqbex.fsf@redhat.com>
        <20211216000229.7a284661.pasic@linux.ibm.com>
        <75637be1-7459-1cdc-3b4d-f8f3225f7b8b@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qqT9yk8k162hTz9zH4KadleJ_7Y80ylq
X-Proofpoint-ORIG-GUID: vzU2cewFKmhyiDoyg5XiR82Exrdbeddn
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_06,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201280004
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 10:04:46 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 12/15/21 18:02, Halil Pasic wrote:
> > On Wed, 15 Dec 2021 13:51:02 +0100
> > Cornelia Huck <cohuck@redhat.com> wrote:
> >  
> >> On Wed, Dec 15 2021, Thomas Huth <thuth@redhat.com> wrote:
> >>  
> >>> On 14/12/2021 22.55, Tony Krowiak wrote:  
> >>>>
> >>>> On 12/13/21 11:11, Cornelia Huck wrote:  
> >>>>> One possibility is simply blocking autoload of the module in userspace by
> >>>>> default, and only allow it to be loaded automatically when e.g. qemu-kvm
> >>>>> is installed on the system. This is obviously something that needs to be
> >>>>> decided by the distros.
> >>>>>
> >>>>> (kvm might actually be autoloaded already, so autoloading vfio-ap would
> >>>>> not really make it worse.)  
> >>>> Of the vfio_ccw module is automatically loaded, then the kvm
> >>>> module will also get loaded. I startup up a RHEL8.3 system and
> >>>> sure enough, the vfio_ccw module is loaded along with the
> >>>> kvm, vfio and mdev modules. If this is true for all distros, then
> >>>> it wouldn't make much difference if the vfio_ap module is
> >>>> autoloaded too.  
> >>> I think I don't mind too much if we auto-load vfio-ap or not - but I think
> >>> we should make it consistent with vfio-ccw. So either auto-load both modules
> >>> (if the corresponding devices are available), or remove the
> >>> MODULE_DEVICE_TABLE() entries from both modules?  
> >> I think we really need to take a step back and think about the purpose
> >> of adding a MODULE_DEVICE_TABLE()... basically, it declares which types
> >> of devices on a certain bus a driver supports, in a way that can be
> >> consumed by userspace (after file2alias.c worked on it).  
> > I did a quick search to locate where this semantic was codified. But
> > I didn't find the place neither Documentation/ nor in the header where
> > MODULE_DEVICE_TABLE is defined.
> >  
> >> Userspace typically uses this to match devices it is notified about to
> >> drivers that could possibly drive those devices. In general, the
> >> assumption is that you will want to have the drivers for your devices
> >> loaded. In some cases (drivers only used in special cases, like here),
> >> it might be a better idea to autoload the drivers only under certain
> >> circumstances (e.g. if you know you're going to run KVM guests).  
> > Does RHEL do this, or would RHEL do this out of the box? I.e.
> > would we end up preserving old behavior when this fix hits the distro,
> > or would the end user end up with kvm and vfio_ap loaded (out of the
> > box)?
> >
> > What would be the mechanism of choice to implement if kvm loaded and
> > APs present/hotplugged load vfio_ap, otherwise don't in the userspace?
> >
> > Sorry I'm not very familiar with this whole modules auto-loading
> > business, so I may be asking obvious questions. But a quick google
> > search did not help me.
> >  
> >> My main point, however, is that we're talking about policy here: whether
> >> a potentially useful driver should be loaded or not is a decision that
> >> should be made by userspace. Not providing a MODULE_DEVICE_TABLE does
> >> not look like the right solution, as it deprives userspace of the
> >> information to autoload the driver, if it actually wants to do so.
> >>  
> > I'm sympathetic to this reading of the situation, but I'm not sure
> > it is as black and white as stated.
> >
> > I think the current state of affairs in the vfio_ap module is clearly a
> > bug.
> >
> > One can argue that not auto-loading vfio_ap and kvm per default out of
> > the box is not a bug. I mean the tooling (chzdev) seems to do fine
> > without this and just assuming that both kvm and vfio_ap will be needed
> > just because we have APs seems wrong.
> >
> > One of the more important guiding principles of Linux kernel development
> > is no userspace regressions. And I think suddenly getting vfio_ap and kvm
> > loaded just because we have AP devices can be thought of as a regression.
> >
> > So I'm sympathetic to Harald's view as well.
> >
> > Of course there is the solution that the distros should really make sure
> > the old behavior is preserved, or some smart behavior is introduced. But
> > regarding smart, I believe "if you have devices that are configured for
> > vfio_ap pass-through (with chzdev), then the vfio_ap module should get
> > loaded" is pretty much as smart as it gets. So blacklisting the module
> > by default in the distros looks like a viable option. If that is what
> > we want, we should probably ask the distros, because I don't think
> > it is just obviously their job to figure out that they have to do so.
> >
> > Disclaimer: I might be wrong about the current behavior, I didn't verify
> > my claims
> >
> > Also what does vfio-pci do?  
> 
>  From vfio_pci.c:
> 
> static const struct pci_device_id vfio_pci_table[] = {
>      { PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_ANY_ID, PCI_ANY_ID) }, /* 
> match all by default */
>      {}
> };
> 
> MODULE_DEVICE_TABLE(pci, vfio_pci_table);

What are you trying to tell me with this? Did you read the paragraph
below? From that paragraph it should be obvious that I was aware of the
fact that vfio-pci does have MODULE_DEVICE_TABLE, but because of the
"override" stuff the vfio-pci module *won't* get auto-loaded (unlike
what is proposed here for the vfio-ap module).
 
> 
> > As far as I can tell vfio-pci does not
> > participate in module auto loading just because there are pci devices.
> > The have some smart override I don't quite understand:
> > https://patchwork.ozlabs.org/project/linux-pci/patch/20210826103912.128972-11-yishaih@nvidia.com/
> > Before, I don't think they had a MODULE_DEVICE_TABLE:
> > https://elixir.bootlin.com/linux/v5.8.18/source/drivers/vfio/pci/vfio_pci.c
> >
> > Regards,
> > Halil  
> 

