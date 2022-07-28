Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1905838B0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 08:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbiG1GVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 02:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiG1GVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 02:21:23 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7587A5C9C2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 23:21:19 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220728062113epoutp01ca4dd614960725381b40d37eb69e01a4~F6fR2jDlP1098210982epoutp01h
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 06:21:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220728062113epoutp01ca4dd614960725381b40d37eb69e01a4~F6fR2jDlP1098210982epoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658989273;
        bh=/evFvAqXQi7c+IqL7X8XjIssIUeaJ50cElJRdAnjasI=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=t5AJovh3z2IZdcfuiCbMHfQaeRcnqw8M4XnBwBVjyQVRUAlP7x4CL3OUJUWD5gCHp
         xuQtSHvK8JW/jDjQwqIxhE/TswVCuBioBebQpQVWwgSq3f8yEAOeEjU+gxlBsKO2pC
         MeFAlcUWowpHwpqcTPnS0ANoxzXVTf9usJ162BWI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220728062113epcas2p321bbcb8e57015f420bd20dbd915b0261~F6fRSpEvo1188011880epcas2p3x;
        Thu, 28 Jul 2022 06:21:13 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.101]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LtgWr5mDgz4x9QC; Thu, 28 Jul
        2022 06:21:12 +0000 (GMT)
X-AuditID: b6c32a48-9f7ff700000025be-eb-62e22ad8a37d
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        64.A2.09662.8DA22E26; Thu, 28 Jul 2022 15:21:12 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH v4 1/7] scsi: ufs: wb: Move ufshcd_is_wb_allowed() to
 callee
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <dfcd22985fde6fe8a8a00bfb2a9c8ee43f92e34b.camel@gmail.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220728062112epcms2p8caabb4288c426b9b7641a7e867c50af3@epcms2p8>
Date:   Thu, 28 Jul 2022 15:21:12 +0900
X-CMS-MailID: 20220728062112epcms2p8caabb4288c426b9b7641a7e867c50af3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmqe4NrUdJBldeSVqcfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBYvD2laLLqxjcni8q45bBbd13ewWSw//o/Jgcvj8hVvj8V7XjJ5
        TFh0gNHj+/oONo+PT2+xePRtWcXo8XmTnEf7gW6mAI6obJuM1MSU1CKF1Lzk/JTMvHRbJe/g
        eOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoBOVFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnF
        JbZKqQUpOQXmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZ915uYSxYIlixYsdkxgbGVwJdjJwc
        EgImEv8ud7F2MXJxCAnsYJToOfmArYuRg4NXQFDi7w5hkBphgVCJllcn2EBsIQEliXNrZjGC
        lAgLGEjc6jUHCbMJ6En8XDKDDWSMiMBZZomFD6cwQcznlZjR/pQFwpaW2L58KyOIzSngLrFl
        5m5GiLiGxI9lvcwQtqjEzdVv2WHs98fmQ9WISLTeOwtVIyjx4CdMr6TEoUNfwU6WEMiX2HAg
        ECJcI/F2+QGoEn2Jax0bwU7gFfCV+LIQ4gQWAVWJVde+QZ3pIvHgxEawtcwC2hLLFr5mBhnJ
        LKApsX6XPsR0ZYkjt1hgnmrY+Jsdnc0swCfRcfgvXHzHvCdMEK1qEouajCDCMhJfD89nn8Co
        NAsRyrOQrJ2FsHYBI/MqRrHUguLc9NRiowITeMQm5+duYgSnVC2PHYyz337QO8TIxMF4iFGC
        g1lJhDch+n6SEG9KYmVValF+fFFpTmrxIUZToIcnMkuJJucDk3peSbyhiaWBiZmZobmRqYG5
        kjivV8qGRCGB9MSS1OzU1ILUIpg+Jg5OqQamhVOXJYk/aj4Y9rFLXmqz0r6Xee9Ygt2vuUyJ
        dJsiyyYZ21w+4Xbb1o2PqlI8327r2ZChK6bklHFOxn3JnPx/b3I+/uh81jdjk69m677QLS37
        9jwtzcp3zD9ZEB11c6/FJee7tmt/XHmj+u3E97+5G9oL0ksdH29jvHrn5iJV567XSt+EpFLt
        J2Y/6nLw1Ltb1Z2b4qjLP7OoV72QXVq/mFFYhEv5VLkqw6UZXM/Lp1y7HFR73CBh+elF4hy2
        xrICHFy3VG2dDwezV1o5TFVfrSWkFl/p8uFSSfPnKNkL4t2lpnyhiam7w/39FnY5nju53uTT
        hX+LvGa8SrEv90y1/fG7Kn6T9dMU8w/xHUosxRmJhlrMRcWJAL5ZMc0yBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d
References: <dfcd22985fde6fe8a8a00bfb2a9c8ee43f92e34b.camel@gmail.com>
        <20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d@epcms2p6>
        <20220727070410epcms2p5206785e4d960b32dcbb6729710dab535@epcms2p5>
        <CGME20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d@epcms2p8>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On=C2=A0Wed,=C2=A02022-07-27=C2=A0at=C2=A016:04=C2=A0+0900,=C2=A0Jinyoung=
=C2=A0CHOI=C2=A0wrote:=0D=0A>>=C2=A0diff=C2=A0--git=C2=A0a/drivers/ufs/core=
/ufshcd.c=C2=A0b/drivers/ufs/core/ufshcd.c=0D=0A>>=C2=A0index=C2=A08f11f118=
c30e..a3bdf9986511=C2=A0100644=0D=0A>>=C2=A0---=C2=A0a/drivers/ufs/core/ufs=
hcd.c=0D=0A>>=C2=A0+++=C2=A0b/drivers/ufs/core/ufshcd.c=0D=0A>>=C2=A0=40=40=
=C2=A0-5722,6=C2=A0+5722,9=C2=A0=40=40=C2=A0static=C2=A0int=C2=A0__ufshcd_w=
b_toggle(struct=C2=A0ufs_hba=0D=0A>>=C2=A0*hba,=C2=A0bool=C2=A0set,=C2=A0en=
um=C2=A0flag_idn=C2=A0idn)=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0enum=C2=A0query_opcode=C2=A0opcode=C2=A0=3D=C2=A0set=C2=A0?=
=C2=A0UPIU_QUERY_OPCODE_SET_FLAG=C2=A0:=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0UPIU_QUERY_OPCODE_CLEAR_FLAG;=0D=0A>=
>=C2=A0=C2=A0=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=
=A0(=21ufshcd_is_wb_allowed(hba))=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=C2=A0=
-EPERM;=0D=0A>>=C2=A0+=0D=0A>Hi=C2=A0J-young,=0D=0A>=0D=0A>here=C2=A0you=C2=
=A0should=C2=A0change=C2=A0its=C2=A0return,=C2=A0Otherwise,=C2=A0there=C2=
=A0will=C2=A0be=C2=A0an=C2=A0fake=0D=0A>error=C2=A0printing:=0D=0A>=0D=0A>=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_err(hba->dev,=C2=A0=22%=
s=C2=A0Write=C2=A0Booster=C2=A0%s=C2=A0failed=C2=A0%d=5Cn=22,=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=0D=0A>=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__func__,=C2=A0enable=C2=
=A0?=C2=A0=22enable=22=C2=A0:=C2=A0=22disable=22,=C2=A0ret);=0D=0A>=0D=0A>=
=0D=0A>Kind=C2=A0regards,=0D=0A>Bean=0D=0A=0D=0AYou=20are=20right=21=0D=0AR=
ather=20than=20changing=20the=20return=20value,=20this=20patch=20is=20likel=
y=20to=20be=20excluded=0D=0Abecause=20caller=20can=20continue=20unnecessary=
=20work.=0D=0A=0D=0AThanks,=20Jinyoung.
