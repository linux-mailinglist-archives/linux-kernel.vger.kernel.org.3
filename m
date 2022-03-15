Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993EA4D98A8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347051AbiCOKZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347006AbiCOKZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:25:56 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FEA39178
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 03:24:43 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220315102441epoutp01a112b20a120110ac9abb6a9760aeb210~chuUGkG4w2368023680epoutp01R
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 10:24:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220315102441epoutp01a112b20a120110ac9abb6a9760aeb210~chuUGkG4w2368023680epoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647339881;
        bh=FsfyjBB7q0DvWz2A7F3Mgvw46I0WUKQTNbFMUprKeZk=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=YHb6fcMMr+9gns/uCN/Mv1JofKy7uuGGK4TSzGp9iDG/nAdOB+7HN2XDiNQcO24lB
         2/YiC36uQ2PeumOx+QMJlB7G6XgW36+pHc/zhE8Hj5d+R6R2ZGSvTZ9n4r/Ct5+OLM
         Gg3mGmryc9MwuN4sAKRDu8N7/bjeahwzKIaqOik8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220315102441epcas2p430a23fe2dfd556a81ea6cb5d396c9ee6~chuTxNEQs1275912759epcas2p4c;
        Tue, 15 Mar 2022 10:24:41 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.100]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KHqK24xDvz4x9Pt; Tue, 15 Mar
        2022 10:24:38 +0000 (GMT)
X-AuditID: b6c32a45-513ff700000228cc-43-62306966ea6c
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        64.A1.10444.66960326; Tue, 15 Mar 2022 19:24:38 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH v2] driver/nvme/host: Support duplicated nsid for the
 private ns
Reply-To: sungup.moon@samsung.com
Sender: Sungup Moon <sungup.moon@samsung.com>
From:   Sungup Moon <sungup.moon@samsung.com>
To:     "hch@lst.de" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220315084611.GA3961@lst.de>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220315102438epcms2p68d757d1863b5582778f8c89517b82a70@epcms2p6>
Date:   Tue, 15 Mar 2022 19:24:38 +0900
X-CMS-MailID: 20220315102438epcms2p68d757d1863b5582778f8c89517b82a70
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdljTVDct0yDJYFanqsX/PcfYLFauPspk
        MenQNUaLy7vmsFnMX/aU3WLd6/csDmweE5vfsXucv7eRxWPTqk42j81L6j1232xg8/i8SS6A
        LSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoCiWF
        ssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgXmBXnFibnFpXrpeXmqJlaGBgZEpUGFC
        dsaLywvZClYKVZy+3sPWwNgq2MXIySEhYCLxcPlCpi5GLg4hgR2MEmt37GPsYuTg4BUQlPi7
        QxikRlggUuLc0ptsILaQgKLE32d9jBBxXYk1/6cwg9hsAtoS9868ZQKxRQTsJXp/TGUFmcks
        cIFR4urjpWwQy3glZrQ/ZYGwpSW2L98KNogTqHnO9dNMEHENiR/LepkhbFGJm6vfssPY74/N
        Z4SwRSRa752FqhGUePBzN1RcUuLpyQ9Q8XyJtt+L2ECOkBDoYJQ4//AI1AJziT8vr4MN5RXw
        lei4vgSsgUVAVWJp/yRmkOclBFwkTuxLBgkzA922bOFrsDCzgKbE+l36EBXKEkdusUBU8El0
        HP7LDvPhjnlPoBapSlyc0MMG8+3KeQ2MEK0eEmteBE9gVJyFCOdZSFbNQli1gJF5FaNYakFx
        bnpqsVGBITxqk/NzNzGCk6OW6w7GyW8/6B1iZOJgPMQowcGsJMJ75oV+khBvSmJlVWpRfnxR
        aU5q8SFGU6AfJzJLiSbnA9NzXkm8oYmlgYmZmaG5kamBuZI4r1fKhkQhgfTEktTs1NSC1CKY
        PiYOTqkGJl++7R/E+R9ke9fnrN2u9b0u0DpfvCw3c4L/02PX9/G8YPq/umua4FZ2ryXBGozO
        d6VZn/y9+EUx/MWWXPHkZYlfZ5f0HGI26rq0V+Ka6J+F5mYOAl8lLfY07k3OWVkVHzl9EZ8E
        0xQ+qdVhp+P+PXxpmrDc7Fb0b0kLF3XL53uKp3Zme6SzZbRK3jR7O4eJ8cHySyFbyh94bRW6
        mHhVKf7dFt+rx39uk37B9f5bifOprE86juGrF9gETl4fFTKdTbN6hnfgjdpfes90/6/flZ4r
        2rrjqO28Fo0u++6T/dnCHAtsamrnNnS5xP39oflnZfSPVWeCpi4/sypZ5dQXe+avJnE7Jyxg
        bPC6s8TUQ4mlOCPRUIu5qDgRAPIC7x0XBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220314110545epcms2p4a227eac7c4652445050e70ee2350635d
References: <20220315084611.GA3961@lst.de>
        <20220314110545epcms2p4a227eac7c4652445050e70ee2350635d@epcms2p4>
        <20220315071230.GA2069@lst.de> <20220315071926.GA2137@lst.de>
        <a3051d85-c08e-a273-c7cc-2eb3e21df717@grimberg.me>
        <20220315084035.GA3834@lst.de>
        <6ac83f8b-01e6-5394-0570-023ac6b1a71d@grimberg.me>
        <CGME20220314110545epcms2p4a227eac7c4652445050e70ee2350635d@epcms2p6>
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First of all private namespace should be created by the vendor specific com=
mand,
because namespace management, ANA and NVM Set should be disabled on the con=
troller
level. So Normal namespace managed NVMe deivce should return true using the
namespace management field (ctrl->oacs & NVME_CTRL_OACS_NS_MNGT_SUPP).

If user create using the namespace management admin command, my patch
check the namespace management field and that sub-system should be managed
like multi-path nvme device route.

So, if user create shared namespace on that nvme subsystem, should
distroy all namespace with target nsid, and create the new shared namespace
using the vendor specific admin command.

=C2=A0=0D=0A=C2=A0=0D=0A---------=20Original=20Message=20---------=0D=0ASen=
der=20:=20hch=40lst.de=C2=A0<hch=40lst.de>=0D=0ADate=20:=202022-03-15=2017:=
46=20(GMT+9)=0D=0ATitle=20:=20Re:=20=5BPATCH=20v2=5D=20driver/nvme/host:=20=
Support=20duplicated=20nsid=20for=20the=20private=20ns=0D=0A=C2=A0=0D=0AOn=
=C2=A0Tue,=C2=A0Mar=C2=A015,=C2=A02022=C2=A0at=C2=A010:42:56AM=C2=A0+0200,=
=C2=A0Sagi=C2=A0Grimberg=C2=A0wrote:=0D=0A>>>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*=C2=A0We=C2=A0also=C2=A0do=C2=A0this=C2=
=A0for=C2=A0private=C2=A0namespaces=C2=A0as=C2=A0the=C2=A0namespace=C2=A0sh=
aring=C2=A0flag=0D=0A>>>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0*=C2=A0could=C2=A0change=C2=A0after=C2=A0a=C2=A0rescan.=0D=0A>>=
>=0D=0A>>>=C2=A0What=C2=A0happens=C2=A0in=C2=A0this=C2=A0case?=C2=A0we=C2=
=A0now=C2=A0have=C2=A0non-unique=C2=A0shared=C2=A0namespaces?=0D=0A>>=0D=0A=
>>=C2=A0The=C2=A0non-uniqueue=C2=A0NSIDs=C2=A0can=C2=A0only=C2=A0happen=C2=
=A0for=C2=A0private=C2=A0namespaces.=0D=0A>=0D=0A>=C2=A0But=C2=A0what=C2=A0=
happens=C2=A0if=C2=A0this=C2=A0changes=C2=A0upon=C2=A0a=C2=A0rescan=C2=A0as=
=C2=A0you=C2=A0commented?=0D=0A=C2=A0=0D=0AWell,=C2=A0it=C2=A0can't=C2=A0ch=
ange=C2=A0to=C2=A0shared=C2=A0as=C2=A0the=C2=A0nsids=C2=A0are=C2=A0non-uniq=
ue.=C2=A0=C2=A0If=C2=A0we=0D=0Awant=C2=A0to=C2=A0be=C2=A0paranoid=C2=A0we=
=C2=A0could=C2=A0add=C2=A0a=C2=A0sanity=C2=A0check=C2=A0for=C2=A0that,=C2=
=A0but=C2=A0then=0D=0Aagain=C2=A0there=C2=A0are=C2=A0a=C2=A0bunch=C2=A0of=
=C2=A0other=C2=A0things=C2=A0where=C2=A0we=C2=A0could=C2=A0be=C2=A0more=C2=
=A0paranoid.=0D=0A=C2=A0
