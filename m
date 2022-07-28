Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D47258363A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 03:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbiG1BTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 21:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbiG1BTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 21:19:01 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D28441990
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 18:19:00 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220728011857epoutp043ca169f10bdae140f068b9e6250e4688~F2XXUOGt70776507765epoutp04J
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 01:18:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220728011857epoutp043ca169f10bdae140f068b9e6250e4688~F2XXUOGt70776507765epoutp04J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658971137;
        bh=ONqAunqwZYTfDxgzM5OVZYL/ihR/N0AERdocHpv6bSM=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=BNHB+3iFgQ3DGGWn5ZjFCXt7N6QTQcIuCqDSj2gKPCtW7MQN5DoXBLp5Yfz7ZKCoE
         eQtLsTtuOAu2v5+reiyJIyM1fJvq75YTBuneNmfg57WxOWOzSdHzHQZpl71Z0LhPrj
         7EOGZbxqNGUVHZuhiyeTxRx021sLaeY7kiUd/eDs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220728011857epcas2p2e87f8691971a0561df32733bc098e090~F2XW9mtd71003110031epcas2p2T;
        Thu, 28 Jul 2022 01:18:57 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.97]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LtXq46Fnsz4x9QC; Thu, 28 Jul
        2022 01:18:56 +0000 (GMT)
X-AuditID: b6c32a48-9e1ff700000025be-77-62e1e4004d35
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.C2.09662.004E1E26; Thu, 28 Jul 2022 10:18:56 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH v4 5/7] scsi: ufs: wb: Add
 ufshcd_is_wb_buf_flush_allowed()
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <90ef5f84-1e4e-d93e-5ee9-acdf36109827@acm.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220728011856epcms2p74ded3da804e42a8b7a15b0d5d85ef630@epcms2p7>
Date:   Thu, 28 Jul 2022 10:18:56 +0900
X-CMS-MailID: 20220728011856epcms2p74ded3da804e42a8b7a15b0d5d85ef630
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMJsWRmVeSWpSXmKPExsWy7bCmhS7Dk4dJBofb9S1OPlnDZvFg3jY2
        i5c/r7JZHHzYyWLx8pCmxaIb25gsLu+aw2bRfX0Hm8Xy4/+YHDg9Fu95yeQxYdEBRo/v6zvY
        PD4+vcXi0bdlFaPH501yHu0HupkC2KOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0t
        LcyVFPISc1NtlVx8AnTdMnOALlNSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgX
        6BUn5haX5qXr5aWWWBkaGBiZAhUmZGdc3D2TseAYT8WnNbYNjHN4uhg5OSQETCROHGhk6WLk
        4hAS2MEosezHCuYuRg4OXgFBib87hEFqhAVCJI6v+M0IYgsJKEmcWzOLEaREWMBA4lavOUiY
        TUBP4ueSGWwgtojAImaJfzvTIMbzSsxof8oCYUtLbF++FWwMp4C1xIHtDcwQcQ2JH8t6oWxR
        iZur37LD2O+PzWeEsEUkWu+dhaoRlHjwczdUXFLi0KGvbCDnSAjkS2w4EAgRrpF4u/wAVIm+
        xLWOjWAn8Ar4Siy5M48JpJxFQFViwaUQiBIXic7Jq8HKmQW0JZYtfA0OA2YBTYn1u/QhhitL
        HLnFAvNTw8bf7OhsZgE+iY7Df+HiO+Y9YYJoVZNY1GQEEZaR+Hp4PvsERqVZiDCehWTtLIS1
        CxiZVzGKpRYU56anFhsVmMBjNTk/dxMjOHVqeexgnP32g94hRiYOxkOMEhzMSiK8CdH3k4R4
        UxIrq1KL8uOLSnNSiw8xmgL9O5FZSjQ5H5i880riDU0sDUzMzAzNjUwNzJXEeb1SNiQKCaQn
        lqRmp6YWpBbB9DFxcEo1MDVmOJ2y2/Xq0b7jFlKnPx7j6crKXfqJdf8spZAT13++jbnZxBsg
        +/fH4eqprJwPrWbaKk26w6K49tqLwEizbembQ87dWnIhcQ13oZRK5i7J5Ebem48t125108i5
        qPLd5u29hcUZy15zT/ztcPbS5jVV4vymGYEBTrzZOezLNBy64jnKF637+zZnE9/K1xuKWObf
        ENr2bMGaENktbxy29j0KduqWVNOVuLzg9LWEjIroaW8P6WpsOWR10sjsvWD5lNDnS3bybhRT
        +hK3w+ajsIe5CPOiXK6H7Xrh5/uOLuw3+/dQlEv5pP434ekfDM9JGKfelJk359OGbQzr7oct
        9b+dvMagcNYG3YmKTrwN3/cqsRRnJBpqMRcVJwIAH9RvniYEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d
References: <90ef5f84-1e4e-d93e-5ee9-acdf36109827@acm.org>
        <20220727070841epcms2p5e212d617dd0f985555fa052f099013f0@epcms2p5>
        <20220727070724epcms2p8e449d0c89b52f03a9d3dc254df0ec547@epcms2p8>
        <20220727070410epcms2p5206785e4d960b32dcbb6729710dab535@epcms2p5>
        <20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d@epcms2p6>
        <20220727071024epcms2p70366b54ac8eca3758b7cf4336e0d457c@epcms2p7>
        <CGME20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d@epcms2p7>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On=C2=A07/27/22=C2=A000:10,=C2=A0Jinyoung=C2=A0CHOI=C2=A0wrote:=0D=0A>>=C2=
=A0diff=C2=A0--git=C2=A0a/include/ufs/ufshcd.h=C2=A0b/include/ufs/ufshcd.h=
=0D=0A>>=C2=A0index=C2=A094bcfec98fb8..78adc556444a=C2=A0100644=0D=0A>>=C2=
=A0---=C2=A0a/include/ufs/ufshcd.h=0D=0A>>=C2=A0+++=C2=A0b/include/ufs/ufsh=
cd.h=0D=0A>>=C2=A0=40=40=C2=A0-1017,6=C2=A0+1017,12=C2=A0=40=40=C2=A0static=
=C2=A0inline=C2=A0bool=C2=A0ufshcd_is_wb_allowed(struct=C2=A0ufs_hba=C2=A0*=
hba)=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0return=C2=A0hba->caps=C2=A0&=C2=A0UFSHCD_CAP_WB_EN;=0D=0A>>=C2=A0=C2=A0=
=C2=A0=7D=0D=0A>>=C2=A0=C2=A0=C2=A0=0D=0A>>=C2=A0+static=C2=A0inline=C2=A0b=
ool=C2=A0ufshcd_is_wb_buf_flush_allowed(struct=C2=A0ufs_hba=C2=A0*hba)=0D=
=0A>>=C2=A0+=7B=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0return=C2=A0ufshcd_is_wb_allowed(hba)=C2=A0&&=0D=0A>>=C2=A0+=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=21(hba->quirks=C2=A0&=C2=A0UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL=
);=0D=0A>>=C2=A0+=7D=0D=0A>=0D=0A>Since=C2=A0this=C2=A0function=C2=A0is=C2=
=A0only=C2=A0used=C2=A0inside=C2=A0the=C2=A0UFS=C2=A0driver=C2=A0core=C2=A0=
it=C2=A0should=C2=A0be=C2=A0=0D=0A>added=C2=A0in=C2=A0drivers/ufs/core/ufsh=
cd-priv.h=C2=A0instead=C2=A0of=C2=A0include/ufs/ufshcd.h.=0D=0A>=0D=0A>Than=
ks,=0D=0A>=0D=0A>Bart.=0D=0A=0D=0AOK,=20I=20will=20move=20it.=0D=0AI=20didn=
't=20know=20the=20exact=20purpose=20of=20ufshcd-priv.h.=0D=0AThank=20you=20=
for=20telling=20me.=0D=0A=0D=0AThanks,=20Jinyoung.
