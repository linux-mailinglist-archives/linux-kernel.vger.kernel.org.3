Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922B0476646
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 00:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbhLOXDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 18:03:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38250 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230487AbhLOXDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 18:03:07 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BFKMiBO006331;
        Wed, 15 Dec 2021 23:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ZWpg6Z7J14anytBQWWtJdaVc/OLN+NvKmma5FSmlj/Q=;
 b=soh22zpbbuhsjD93qCpT5CkgHqetwIfoiYJWCTVBYO4x+jr+xN9tZnfqOxD+mkOHAM4o
 kNGwJ207WMZyR/VyPvfsOoWlY8mx2bl2zbt8jRJH4D8kFyjejIjBd27lnMJys6943aI5
 hfNHTVtJFfaONIeDJPNj5WArBtVww9rc02JZ2agGv5PNvIdPuQxSfaf3vBmDwGX9KHye
 wJhrDD3DNeRlDaK8rlfrRr5gQmAEGiDAhrzwfFHW50KgNNNkm1s/9tsUAl0THanyFLuM
 5+FxNIhonqav2tLSba84DzHOmuy/62IRVpW+EDIXv04D5fjiH6KrhZtxrc1KGXOo9G3o Dw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cyqbhjngq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 23:03:06 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BFN36gU030158;
        Wed, 15 Dec 2021 23:03:06 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cyqbhjnfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 23:03:06 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BFN2CDD014774;
        Wed, 15 Dec 2021 23:03:04 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3cy7k9951m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 23:03:03 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BFMt0nY38076706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 22:55:00 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F61EAE068;
        Wed, 15 Dec 2021 23:03:00 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD118AE05A;
        Wed, 15 Dec 2021 23:02:59 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.20.66])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed, 15 Dec 2021 23:02:59 +0000 (GMT)
Date:   Thu, 16 Dec 2021 00:02:29 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Thomas Huth <thuth@redhat.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org, Jason Herne <jjherne@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH] s390: vfio-ap: Register the vfio_ap module for the
 "ap" parent bus
Message-ID: <20211216000229.7a284661.pasic@linux.ibm.com>
In-Reply-To: <87tufaqbex.fsf@redhat.com>
References: <20211201141110.94636-1-thuth@redhat.com>
        <8512bb0a-a34a-09b0-65f3-781f3d092364@linux.ibm.com>
        <87k0g8scx1.fsf@redhat.com>
        <1eb9ca5c-b1bb-b768-64ee-e4a1b31bb171@linux.ibm.com>
        <6aaf6c60-a258-29e3-fcec-82c77d3945a4@redhat.com>
        <87tufaqbex.fsf@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: m7HlbMuXrQxeJIIAHruMt_PIiNOMuKyr
X-Proofpoint-ORIG-GUID: X3StS-SGM1FJX8ORJ9HFNQeDN29OdjZh
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-15_13,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 priorityscore=1501 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112150127
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021 13:51:02 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, Dec 15 2021, Thomas Huth <thuth@redhat.com> wrote:
> 
> > On 14/12/2021 22.55, Tony Krowiak wrote:  
> >> 
> >> 
> >> On 12/13/21 11:11, Cornelia Huck wrote:  
> >>> One possibility is simply blocking autoload of the module in userspace by
> >>> default, and only allow it to be loaded automatically when e.g. qemu-kvm
> >>> is installed on the system. This is obviously something that needs to be
> >>> decided by the distros.
> >>>
> >>> (kvm might actually be autoloaded already, so autoloading vfio-ap would
> >>> not really make it worse.)  
> >> 
> >> Of the vfio_ccw module is automatically loaded, then the kvm
> >> module will also get loaded. I startup up a RHEL8.3 system and
> >> sure enough, the vfio_ccw module is loaded along with the
> >> kvm, vfio and mdev modules. If this is true for all distros, then
> >> it wouldn't make much difference if the vfio_ap module is
> >> autoloaded too.  
> >
> > I think I don't mind too much if we auto-load vfio-ap or not - but I think 
> > we should make it consistent with vfio-ccw. So either auto-load both modules 
> > (if the corresponding devices are available), or remove the 
> > MODULE_DEVICE_TABLE() entries from both modules?  
> 
> I think we really need to take a step back and think about the purpose
> of adding a MODULE_DEVICE_TABLE()... basically, it declares which types
> of devices on a certain bus a driver supports, in a way that can be
> consumed by userspace (after file2alias.c worked on it).

I did a quick search to locate where this semantic was codified. But
I didn't find the place neither Documentation/ nor in the header where
MODULE_DEVICE_TABLE is defined.

> 
> Userspace typically uses this to match devices it is notified about to
> drivers that could possibly drive those devices. In general, the
> assumption is that you will want to have the drivers for your devices
> loaded. In some cases (drivers only used in special cases, like here),
> it might be a better idea to autoload the drivers only under certain
> circumstances (e.g. if you know you're going to run KVM guests).

Does RHEL do this, or would RHEL do this out of the box? I.e.
would we end up preserving old behavior when this fix hits the distro,
or would the end user end up with kvm and vfio_ap loaded (out of the
box)?

What would be the mechanism of choice to implement if kvm loaded and
APs present/hotplugged load vfio_ap, otherwise don't in the userspace?

Sorry I'm not very familiar with this whole modules auto-loading
business, so I may be asking obvious questions. But a quick google
search did not help me.

> 
> My main point, however, is that we're talking about policy here: whether
> a potentially useful driver should be loaded or not is a decision that
> should be made by userspace. Not providing a MODULE_DEVICE_TABLE does
> not look like the right solution, as it deprives userspace of the
> information to autoload the driver, if it actually wants to do so.
> 

I'm sympathetic to this reading of the situation, but I'm not sure
it is as black and white as stated.

I think the current state of affairs in the vfio_ap module is clearly a
bug.

One can argue that not auto-loading vfio_ap and kvm per default out of
the box is not a bug. I mean the tooling (chzdev) seems to do fine
without this and just assuming that both kvm and vfio_ap will be needed
just because we have APs seems wrong.

One of the more important guiding principles of Linux kernel development
is no userspace regressions. And I think suddenly getting vfio_ap and kvm
loaded just because we have AP devices can be thought of as a regression.

So I'm sympathetic to Harald's view as well.

Of course there is the solution that the distros should really make sure
the old behavior is preserved, or some smart behavior is introduced. But
regarding smart, I believe "if you have devices that are configured for
vfio_ap pass-through (with chzdev), then the vfio_ap module should get
loaded" is pretty much as smart as it gets. So blacklisting the module
by default in the distros looks like a viable option. If that is what
we want, we should probably ask the distros, because I don't think
it is just obviously their job to figure out that they have to do so.

Disclaimer: I might be wrong about the current behavior, I didn't verify
my claims

Also what does vfio-pci do? As far as I can tell vfio-pci does not
participate in module auto loading just because there are pci devices.
The have some smart override I don't quite understand:
https://patchwork.ozlabs.org/project/linux-pci/patch/20210826103912.128972-11-yishaih@nvidia.com/
Before, I don't think they had a MODULE_DEVICE_TABLE:
https://elixir.bootlin.com/linux/v5.8.18/source/drivers/vfio/pci/vfio_pci.c

Regards,
Halil 
