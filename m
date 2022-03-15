Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115184D9839
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346876AbiCOJ5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346872AbiCOJ5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:57:37 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517A72AF1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 02:56:25 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220315095623epoutp01c7fcf540127e8b47d611ab4f08d4a100~chVmOEZmP3155931559epoutp01y
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:56:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220315095623epoutp01c7fcf540127e8b47d611ab4f08d4a100~chVmOEZmP3155931559epoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647338183;
        bh=27qY133tG6B7B64pRYJ8si0/GF15Kh+wuSUhkAsKFvk=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=ndlfi7CJadLyrhn9yBdnK/CoJxMpjxRRltGyuiOLH8cwq2enyDI90glvKh4QFx9nb
         qNjMPUTPlqIR3QpZARQdf3vLqVdETJ3hNEvzrATO3YEpRiElXjzfuEm1ypeT6u5u7l
         N5QZglFbPin3mcJrKRmGrPrPED+5vMJrf9Hbrwmg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220315095622epcas2p23063ecfe190cfd4a5d84e3f65a7d1d1b~chVloz4EJ1553415534epcas2p2o;
        Tue, 15 Mar 2022 09:56:22 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.90]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KHphN1JlDz4x9QH; Tue, 15 Mar
        2022 09:56:20 +0000 (GMT)
X-AuditID: b6c32a46-bffff70000023ea8-64-623062bdc807
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        98.F8.16040.DB260326; Tue, 15 Mar 2022 18:56:13 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH v2] driver/nvme/host: Support duplicated nsid for the
 private ns
Reply-To: sungup.moon@samsung.com
Sender: Sungup Moon <sungup.moon@samsung.com>
From:   Sungup Moon <sungup.moon@samsung.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220315071230.GA2069@lst.de>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220315095612epcms2p304482f5160ae91a120d719c88dbe368d@epcms2p3>
Date:   Tue, 15 Mar 2022 18:56:12 +0900
X-CMS-MailID: 20220315095612epcms2p304482f5160ae91a120d719c88dbe368d
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdljTTHdvkkGSwa+VEhb/9xxjs1i5+iiT
        xaRD1xgtLu+aw2Yxf9lTdot1r9+zOLB5TGx+x+5x/t5GFo9NqzrZPDYvqffYfbOBzePzJrkA
        tqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygK5QU
        yhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BeYFesWJucWleel6eaklVoYGBkamQIUJ
        2RlTfyxiK9ibXXHoyiq2BsYJ6V2MnBwSAiYSy6/vY+1i5OIQEtjBKHFr6kcgh4ODV0BQ4u8O
        YZAaYYFIiXNLb7KB2EICihJ/n/UxQsR1Jdb8n8IMYrMJaEvcO/OWCaRVREBW4sqKepCRzAI/
        GSVet7xmg9jFKzGj/SkLhC0tsX35VrA5nEC9lz5dZYeIa0j8WNbLDGGLStxc/ZYdxn5/bD4j
        hC0i0XrvLFSNoMSDn7uh4pIST09+gIrnS7T9XsQGcoSEQAejxPmHR5ggEuYSf15eBxvKK+Ar
        sbttM9hBLAKqErP/fIFa5iLx7uMuMJsZ6LhlC18zgzzGLKApsX6XPogpIaAsceQWC0QFn0TH
        4b/sMC/umPcEapOqxMUJPWww766c18AI0eohseZF8ARGxVmIcJ6FZNUshFULGJlXMYqlFhTn
        pqcWGxUYwaM2OT93EyM4OWq57WCc8vaD3iFGJg7GQ4wSHMxKIrxnXugnCfGmJFZWpRblxxeV
        5qQWH2I0BXpyIrOUaHI+MD3nlcQbmlgamJiZGZobmRqYK4nzeqVsSBQSSE8sSc1OTS1ILYLp
        Y+LglGpgSpR/v23nO7bJr8+lGlhueivuxV5cvFF48+35D8/d8L/dsz7//IubTwT2OmhscLA2
        yV69cVXbEZsZvz7wno4OCEs+9cTp6cIqh64dy8oP9i6t8Ob+Fdln9/bK/JTpZ16dqrvQsjkk
        nNv2G1ux6tdrHsViTDtu9xgWNz/a/Fe1dM/9P/vO5ZpVT5njulK0eZPK662Rf7fPeSupFCI7
        Y7pbuEuM+tuceV6sUQuPqJrMtg+z/ndOQYhh7ksLgVmOf+7KzHiTdKDPOdzkyUPfiLTL109I
        z73dtGtdQJOpuWygIduvA+vWV0/y37lnb23tgSOBa5o6/nE5r5RaOXOepIej8M4ZWZYvtQ5M
        cOjd5dPY3q3EUpyRaKjFXFScCADG1ZJtFwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220314110545epcms2p4a227eac7c4652445050e70ee2350635d
References: <20220315071230.GA2069@lst.de>
        <20220314110545epcms2p4a227eac7c4652445050e70ee2350635d@epcms2p4>
        <CGME20220314110545epcms2p4a227eac7c4652445050e70ee2350635d@epcms2p3>
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'll answer your opinion.

1. ns_head leak issue

I don't think that is leaked ns_head. Because although all ids and nsid are=
 same
through all namespaces, each namespaces are indenpendent namespace and each=
 of that
should have independent data structure.
Duplicated nsid private namespace is different from the shared namespace ev=
en though
same information.

2. nvme_mpath_set_disk_name issue

Yes, I also agree that subsystem-wide IDA is very important data. However, =
I
implemented without nvme_mpath_set_disk_name modification at the first time=
, it is
hard to decide which namespace are connected to private controller.

As you know, each nvme controller start initiating at a time. So, each cont=
roller
structures are sequentially initiated, but each namespaces structures are i=
nitiated
independently because of multi-processing on cpu. So, all namespace can hav=
e different
instance number every boot-up time, and it makes hard to track and control =
the private
namespace on the controller or device failure.

Anyway, the private namespace is same condition with no-multipath situation=
 (because
private namespace cannot shared between controllers) so I think that the pr=
ivate
namespace should follow the naming rule with no-multipath situation.

=C2=A0=0D=0A---------=20Original=20Message=20---------=0D=0ASender=20:=20hc=
h=40lst.de=C2=A0<hch=40lst.de>=0D=0ADate=20:=202022-03-15=2016:12=20(GMT+9)=
=0D=0ATitle=20:=20Re:=20=5BPATCH=20v2=5D=20driver/nvme/host:=20Support=20du=
plicated=20nsid=20for=20the=20private=20ns=0D=0A=C2=A0=0D=0AI=C2=A0looked=
=C2=A0at=C2=A0this=C2=A0a=C2=A0bit=C2=A0more=C2=A0and=C2=A0found=C2=A0two=
=C2=A0issues:=0D=0A=C2=A0=0D=0A=C2=A0-=C2=A0nvme_init_ns_head=C2=A0will=C2=
=A0now=C2=A0leak=C2=A0the=C2=A0ns_head=C2=A0for=C2=A0the=C2=A0private=C2=A0=
namespaces=0D=0A=C2=A0=C2=A0=C2=A0with=C2=A0potentially=C2=A0duplicate=C2=
=A0IDs=C2=A0case.=0D=0A=C2=A0-=C2=A0nvme_mpath_set_disk_name=C2=A0still=C2=
=A0needs=C2=A0to=C2=A0use=C2=A0the=C2=A0subsystem-wide=C2=A0IDA=0D=0A=C2=A0=
=C2=A0=C2=A0for=C2=A0the=C2=A0nvme=C2=A0instance=C2=A0name=C2=A0as=C2=A0the=
=C2=A0subsystem=C2=A0and=C2=A0controller=C2=A0ones=0D=0A=C2=A0=C2=A0=C2=A0c=
ould=C2=A0otherwise=C2=A0clash.=0D=0A=C2=A0=0D=0ALet=C2=A0me=C2=A0know=C2=
=A0what=C2=A0you=C2=A0think=C2=A0of=C2=A0this=C2=A0version:=0D=0A=C2=A0=0D=
=0A---=0D=0AFrom=C2=A01b217962cc10fa59eae98fc112adc64bddc462b3=C2=A0Mon=C2=
=A0Sep=C2=A017=C2=A000:00:00=C2=A02001=0D=0AFrom:=C2=A0Sungup=C2=A0Moon=C2=
=A0<sungup.moon=40samsung.com>=0D=0ADate:=C2=A0Mon,=C2=A014=C2=A0Mar=C2=A02=
022=C2=A020:05:45=C2=A0+0900=0D=0ASubject:=C2=A0nvme:=C2=A0allow=C2=A0dupli=
cated=C2=A0NSIDs=C2=A0for=C2=A0the=C2=A0private=C2=A0namespaces=0D=0A=C2=A0=
=0D=0AA=C2=A0NVMe=C2=A0subsystem=C2=A0with=C2=A0multiple=C2=A0controller=C2=
=A0can=C2=A0have=C2=A0private=C2=A0namespaces=0D=0Athat=C2=A0use=C2=A0the=
=C2=A0same=C2=A0NSID=C2=A0under=C2=A0some=C2=A0conditions:=0D=0A=C2=A0=0D=
=0A=C2=A0=22If=C2=A0Namespace=C2=A0Management,=C2=A0ANA=C2=A0Reporting,=C2=
=A0or=C2=A0NVM=C2=A0Sets=C2=A0are=C2=A0supported,=C2=A0the=0D=0A=C2=A0=C2=
=A0NSIDs=C2=A0shall=C2=A0be=C2=A0unique=C2=A0within=C2=A0the=C2=A0NVM=C2=A0=
subsystem.=C2=A0If=C2=A0the=C2=A0Namespace=0D=0A=C2=A0=C2=A0Management,=C2=
=A0ANA=C2=A0Reporting,=C2=A0and=C2=A0NVM=C2=A0Sets=C2=A0are=C2=A0not=C2=A0s=
upported,=C2=A0then=C2=A0NSIDs:=0D=0A=C2=A0=C2=A0=C2=A0a)=C2=A0for=C2=A0sha=
red=C2=A0namespace=C2=A0shall=C2=A0be=C2=A0unique;=C2=A0and=0D=0A=C2=A0=C2=
=A0=C2=A0b)=C2=A0for=C2=A0private=C2=A0namespace=C2=A0are=C2=A0not=C2=A0req=
uired=C2=A0to=C2=A0be=C2=A0unique.=22=0D=0A=C2=A0=0D=0AReference:=C2=A0Sect=
ion=C2=A06.1.6=C2=A0NSID=C2=A0and=C2=A0Namespace=C2=A0Usage;=C2=A0NVM=C2=A0=
Express=C2=A01.4c=C2=A0spec.=0D=0A=C2=A0=0D=0AMake=C2=A0sure=C2=A0this=C2=
=A0specific=C2=A0setup=C2=A0is=C2=A0supported=C2=A0in=C2=A0Linux.=0D=0A=C2=
=A0=0D=0ASigned-off-by:=C2=A0Sungup=C2=A0Moon=C2=A0<sungup.moon=40samsung.c=
om>=0D=0ASigned-off-by:=C2=A0Christoph=C2=A0Hellwig=C2=A0<hch=40lst.de>=0D=
=0A---=0D=0A=C2=A0drivers/nvme/host/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=7C=C2=A0=C2=A07=C2=A0++++++-=0D=0A=C2=A0drivers/nvme/host/multipath.c=
=C2=A0=7C=C2=A0=C2=A07=C2=A0++++---=0D=0A=C2=A0drivers/nvme/host/nvme.h=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7C=C2=A019=C2=A0+++++++++++++++++++=0D=0A=
=C2=A0include/linux/nvme.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=7C=C2=A0=C2=A01=C2=A0+=0D=0A=C2=A04=C2=A0files=C2=A0changed,=
=C2=A030=C2=A0insertions(+),=C2=A04=C2=A0deletions(-)=0D=0A=C2=A0=0D=0Adiff=
=C2=A0--git=C2=A0a/drivers/nvme/host/core.c=C2=A0b/drivers/nvme/host/core.c=
=0D=0Aindex=C2=A0f8084ded69e50..c7127d439b3de=C2=A0100644=0D=0A---=C2=A0a/d=
rivers/nvme/host/core.c=0D=0A+++=C2=A0b/drivers/nvme/host/core.c=0D=0A=40=
=40=C2=A0-3657,7=C2=A0+3657,12=C2=A0=40=40=C2=A0static=C2=A0struct=C2=A0nvm=
e_ns_head=C2=A0*nvme_find_ns_head(struct=C2=A0nvme_subsystem=C2=A0*subsys,=
=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lockdep_assert_=
held(&subsys->lock);=0D=0A=C2=A0=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0list_for_each_entry(h,=C2=A0&subsys->nsheads,=C2=A0entry)=
=C2=A0=7B=0D=0A-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0(h->ns_id=C2=A0=21=3D=C2=A0n=
sid)=0D=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*=0D=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*=C2=
=A0Private=C2=A0namespaces=C2=A0can=C2=A0share=C2=A0NSIDs=C2=A0under=C2=A0s=
ome=C2=A0conditions.=0D=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*=C2=A0In=C2=A0that=
=C2=A0case=C2=A0we=C2=A0can't=C2=A0use=C2=A0the=C2=A0same=C2=A0ns_head=C2=
=A0for=C2=A0namespaces=0D=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*=C2=A0with=C2=A0t=
he=C2=A0same=C2=A0NSID.=0D=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/=0D=0A+=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0if=C2=A0(h->ns_id=C2=A0=21=3D=C2=A0nsid=C2=A0=7C=7C=C2=A0=21nvm=
e_is_uniqueue_nsid(ctrl,=C2=A0head))=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0continue;=0D=0A=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0if=C2=A0(=21list_empty(&h->list)=C2=A0&&=C2=A0nvme_tryget_ns_head(=
h))=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0return=C2=A0h;=0D=0Adiff=C2=A0--git=C2=A0a/drivers/nvme/host/multi=
path.c=C2=A0b/drivers/nvme/host/multipath.c=0D=0Aindex=C2=A0d13b81cd6225c..=
6b6df1016cb91=C2=A0100644=0D=0A---=C2=A0a/drivers/nvme/host/multipath.c=0D=
=0A+++=C2=A0b/drivers/nvme/host/multipath.c=0D=0A=40=40=C2=A0-504,10=C2=A0+=
504,11=C2=A0=40=40=C2=A0int=C2=A0nvme_mpath_alloc_disk(struct=C2=A0nvme_ctr=
l=C2=A0*ctrl,=C2=A0struct=C2=A0nvme_ns_head=C2=A0*head)=0D=0A=C2=A0=0D=0A=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*=0D=0A=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*=C2=A0Add=C2=A0a=C2=A0mult=
ipath=C2=A0node=C2=A0if=C2=A0the=C2=A0subsystems=C2=A0supports=C2=A0multipl=
e=C2=A0controllers.=0D=0A-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0*=C2=A0We=C2=A0also=C2=A0do=C2=A0this=C2=A0for=C2=A0private=C2=A0name=
spaces=C2=A0as=C2=A0the=C2=A0namespace=C2=A0sharing=C2=A0data=C2=A0could=0D=
=0A-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*=C2=A0change=C2=
=A0after=C2=A0a=C2=A0rescan.=0D=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0*=C2=A0We=C2=A0also=C2=A0do=C2=A0this=C2=A0for=C2=A0private=
=C2=A0namespaces=C2=A0as=C2=A0the=C2=A0namespace=C2=A0sharing=C2=A0flag=0D=
=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*=C2=A0could=C2=
=A0change=C2=A0after=C2=A0a=C2=A0rescan.=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/=0D=0A-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0if=C2=A0(=21(ctrl->subsys->cmic=C2=A0&=C2=A0NVME_CTRL_CMIC_M=
ULTI_CTRL)=C2=A0=7C=7C=C2=A0=21multipath)=0D=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if=C2=A0(=21(ctrl->subsys->cmic=C2=A0&=C2=A0NVME_CTRL_=
CMIC_MULTI_CTRL)=C2=A0=7C=7C=0D=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=21nvme_is_uniqueue_nsid(ctrl,=C2=A0head)=
=C2=A0=7C=7C=C2=A0=21multipath)=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=C2=
=A00;=0D=0A=C2=A0=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0head->disk=C2=A0=3D=C2=A0blk_alloc_disk(ctrl->numa_node);=0D=0Adiff=C2=
=A0--git=C2=A0a/drivers/nvme/host/nvme.h=C2=A0b/drivers/nvme/host/nvme.h=0D=
=0Aindex=C2=A0587d92df118b7..9add586434929=C2=A0100644=0D=0A---=C2=A0a/driv=
ers/nvme/host/nvme.h=0D=0A+++=C2=A0b/drivers/nvme/host/nvme.h=0D=0A=40=40=
=C2=A0-718,6=C2=A0+718,25=C2=A0=40=40=C2=A0static=C2=A0inline=C2=A0bool=C2=
=A0nvme_check_ready(struct=C2=A0nvme_ctrl=C2=A0*ctrl,=C2=A0struct=C2=A0requ=
est=C2=A0*rq,=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=C2=A0queue_live;=0D=
=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=C2=A0__nvme=
_check_ready(ctrl,=C2=A0rq,=C2=A0queue_live);=0D=0A=C2=A0=7D=0D=0A+=0D=0A+/=
*=0D=0A+=C2=A0*=C2=A0NSID=C2=A0shall=C2=A0be=C2=A0unique=C2=A0for=C2=A0all=
=C2=A0shared=C2=A0namespaces,=C2=A0or=C2=A0if=C2=A0at=C2=A0least=C2=A0one=
=C2=A0of=C2=A0the=0D=0A+=C2=A0*=C2=A0following=C2=A0conditions=C2=A0is=C2=
=A0met:=0D=0A+=C2=A0*=C2=A0=C2=A0=C2=A01.=C2=A0Namespace=C2=A0Management=C2=
=A0is=C2=A0supported=C2=A0by=C2=A0the=C2=A0controller=0D=0A+=C2=A0*=C2=A0=
=C2=A0=C2=A02.=C2=A0ANA=C2=A0is=C2=A0supported=C2=A0by=C2=A0the=C2=A0contro=
ller=0D=0A+=C2=A0*=C2=A0=C2=A0=C2=A03.=C2=A0NVM=C2=A0Set=C2=A0are=C2=A0supp=
orted=C2=A0by=C2=A0the=C2=A0controller=0D=0A+=C2=A0*=0D=0A+=C2=A0*=C2=A0In=
=C2=A0other=C2=A0case,=C2=A0private=C2=A0namespace=C2=A0are=C2=A0not=C2=A0r=
equired=C2=A0to=C2=A0report=C2=A0a=C2=A0unique=C2=A0NSID.=0D=0A+=C2=A0*/=0D=
=0A+static=C2=A0inline=C2=A0bool=C2=A0nvme_is_uniqueue_nsid(struct=C2=A0nvm=
e_ctrl=C2=A0*ctrl,=0D=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct=C2=A0nvme_ns_head=C2=
=A0*head)=0D=0A+=7B=0D=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0r=
eturn=C2=A0head->shared=C2=A0=7C=7C=0D=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(ctrl->oacs=
=C2=A0&=C2=A0NVME_CTRL_OACS_NS_MNGT_SUPP)=C2=A0=7C=7C=0D=0A+=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0(ctrl->subsys->cmic=C2=A0&=C2=A0NVME_CTRL_CMIC_ANA)=C2=A0=7C=7C=0D=0A=
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0(ctrl->ctratt=C2=A0&=C2=A0NVME_CTRL_CTRATT_NVM_SETS=
);=0D=0A+=7D=0D=0A+=0D=0A=C2=A0int=C2=A0nvme_submit_sync_cmd(struct=C2=A0re=
quest_queue=C2=A0*q,=C2=A0struct=C2=A0nvme_command=C2=A0*cmd,=0D=0A=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0void=C2=A0*buf,=C2=A0unsigned=C2=A0bufflen);=0D=0A=C2=
=A0int=C2=A0__nvme_submit_sync_cmd(struct=C2=A0request_queue=C2=A0*q,=C2=A0=
struct=C2=A0nvme_command=C2=A0*cmd,=0D=0Adiff=C2=A0--git=C2=A0a/include/lin=
ux/nvme.h=C2=A0b/include/linux/nvme.h=0D=0Aindex=C2=A09dbc3ef4daf7c..2dcee3=
4d467d6=C2=A0100644=0D=0A---=C2=A0a/include/linux/nvme.h=0D=0A+++=C2=A0b/in=
clude/linux/nvme.h=0D=0A=40=40=C2=A0-345,6=C2=A0+345,7=C2=A0=40=40=C2=A0enu=
m=C2=A0=7B=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0NVME_=
CTRL_ONCS_TIMESTAMP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D=C2=A01=C2=A0<<=C2=A06,=0D=0A=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0NVME_CTRL_VWC_PRESENT=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D=C2=
=A01=C2=A0<<=C2=A00,=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0NVME_CTRL_OACS_SEC_SUPP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D=C2=A01=C2=A0<<=
=C2=A00,=0D=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0NVME_CTRL_OA=
CS_NS_MNGT_SUPP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D=C2=A01=C2=A0<<=C2=A03,=0D=0A=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0NVME_CTRL_OACS_DIRECTIVES=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=3D=C2=A01=C2=A0<<=C2=A05,=0D=0A=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0NVME_CTRL_OACS_DBBUF_SUPP=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=3D=C2=A01=C2=A0<<=C2=A08,=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0NVME_CTRL_LPA_CMD_EFFECTS_LOG=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D=C2=
=A01=C2=A0<<=C2=A01,=0D=0A--=C2=A0=0D=0A2.30.2=0D=0A=C2=A0=0D=0A=C2=A0
