Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC2459B601
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 20:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiHUSVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 14:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbiHUSVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 14:21:11 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B17A20BDD
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 11:21:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J71ZupceJCMQvneiBgmj2hca6uHhOyI9b5nhyncoPcJHycjFYnFaPteiqHrcIvp7o+dO3ZbjkF7VVBbL+QrfXsnm8EG63JXvOufTbSeE3EWWrMTkYlHnBgw4B0QHG0j3z9v8KUmNdseU388W5z/DOPzwl4hYFcwiEwPRy3NtB2po8WUx/VnLkmqAkKoTxMyA9qtIx9Hp6XGOKVs7kZbR/WCwqUr0lNJznWLTEgj8BrHYniETQt+0UaPhhsFPmjJFJbazsT5338QOkdM+rjQhd6O9flkS2wzzkkyRiZPt/y5IqwxZGlqXwDVsJTy9VaFWAVpy2xQKsPZI9ZF75tDsdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AI4DsnO/FjB9zxhd2amaIto2lQ0CBzw8MtRNR49vi4Q=;
 b=UFzaHWcQM7FOkMYmSc97EEiyAPS1LUKx93znkWnSN+bNvkLrJnC3tOuG/9dFGvDS//3lYsBlOOcLH9TMdxaA/fS0C9pR02sWS8/flhos79B6m+AcvNPzjVgmIwBfPYNLn+Ve8hq+PKjMtEkNJwpiAw3pnPPjDl7hvF8g6dqNkDYfvb20M0GKZAav45UM6wJbwtgMpnZ8AaIBR0sMP7TrpjudO7jnlgxV8aVPEKokZ6objdU2/zf7JWJCKMkExnoFqNugNQvQQEuUegXjUKtR630X2ZY9Ph290VL42CjhMU3wST4Eiwy3jsK7N3+3n2aqAeW8+gmjuKK5Az/rh6mrcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AI4DsnO/FjB9zxhd2amaIto2lQ0CBzw8MtRNR49vi4Q=;
 b=dnt9yPgmA+VEOZvVsn0VV+g9DCxGs1Pyb02hQTrsC4f6PU4QLi7qUgrpFYIejxfE6+59NFAprfKDCpwd+B+HOsYZCr4kxkhYE6NP40LcSx+Q3skqixHGPCEI82+pR2Oua3Jbl9yCG+sdZrj9BtN9XOmRFJ7c5kfftKc4DMfgBU8=
Received: from PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24)
 by BN8PR10MB3330.namprd10.prod.outlook.com (2603:10b6:408:c1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Sun, 21 Aug
 2022 18:21:04 +0000
Received: from PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::f946:8762:96dc:6eb]) by PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::f946:8762:96dc:6eb%4]) with mapi id 15.20.5546.022; Sun, 21 Aug 2022
 18:21:04 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     Yifei Liu <yifeliu@cs.stonybrook.edu>
CC:     "ezk@cs.stonybrook.edu" <ezk@cs.stonybrook.edu>,
        "madkar@cs.stonybrook.edu" <madkar@cs.stonybrook.edu>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Kyeong Yoo <kyeong.yoo@alliedtelesis.co.nz>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] jffs2: correct logic when creating a hole in
 jffs2_write_begin
Thread-Topic: [PATCH] jffs2: correct logic when creating a hole in
 jffs2_write_begin
Thread-Index: AQHYp1GL3Ep6t2pZ9Uewp2J/7maioa25xpiV
Date:   Sun, 21 Aug 2022 18:21:04 +0000
Message-ID: <PH0PR10MB46153A784F27AE96DA69120DF46E9@PH0PR10MB4615.namprd10.prod.outlook.com>
References: <20220803155315.2073584-1-yifeliu@cs.stonybrook.edu>
In-Reply-To: <20220803155315.2073584-1-yifeliu@cs.stonybrook.edu>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=infinera.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58bbcb96-0fe6-4d3f-332e-08da83a1e899
x-ms-traffictypediagnostic: BN8PR10MB3330:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VsYAFynISD2iuCfq5wQwzqfLXD89t2ZwIGZxv0RzIoJtRZkCYR+ezZ4uNnCHMuZ+zckONJkgPBE60SuLU/kGDDhLz+fFDdt55aTFSm2tUzIdPJk4iTfbz5dlahQiL1fnc+/Oo8CGd9kmZtt9vxQ9RI753HC5yKwCdbACHz7poeEsTZqruftlh7GSZgzuLm8D9kH5AYh1sHWlzXhw9MZQ32rOWaEH1AcKMZyVh6nAkVKqU7tePFNwf5cdHXhkA31Msnp+s4j7YHzwFnTu6Q2ICoGnJp9YGFKmxh3tU0/2hXkBX9LslE8ujr9HDxEXD2sIX/o6WbsXlGxboq0bqiXPwUeTYaj0RzqY/eSBMmqb2GbTjy8aTyhsUQpHrfkyS5ZsWUuq3WRe74di8zLUcp7bBBGro9FsqXg9gf94EAQViWW87CDbmRQhGd5tGfd8NKTIy7t3w36Rz8d41xjHSI1e/zdzMCbowkHKvV8SoK21BDcN47G5h0EU63SDZQk3aDGHXsj0b6YTKByF1nbZoc3lOwYtNoslpUtMwum9h5lVicWRI9taCAcFoPYIo/Ua7Yyj12x/wF4jidQ7gNwqP4O0Vc+Nindnh1l3YyiGypNcF/1lj3P8IzPt7fKaJXonxj3cSe2BOKuDhG4xLxMUGoA5no4cHFan+kMdYO9VeYrQzZNstGxCzcLtQ31A933kSoaW3BpNlWyEni90UoQkSjewk2/ixVNdWd4s0jfEl5xCmdIHkgJDjFt3ASIziPIVUezs3rmpBs/ln7MGpy93nuG2pgxJ0bbkNJ6gCSzzqXmnIwk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4615.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(366004)(136003)(396003)(346002)(376002)(186003)(478600001)(122000001)(966005)(7696005)(6506007)(26005)(9686003)(38100700002)(5660300002)(66556008)(8676002)(66476007)(8936002)(52536014)(33656002)(4326008)(66446008)(64756008)(2906002)(86362001)(76116006)(54906003)(6916009)(91956017)(66946007)(45080400002)(83380400001)(71200400001)(316002)(38070700005)(55016003)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rcT6+uLmHj0l7zF56RGSFTWiEJneoVe97WHYMSU9raEeoJzB9jO1c4Db/B?=
 =?iso-8859-1?Q?WQrtn0lYSf+yASbfSx+JobPJxXN29TmW7j0Zb9WR4Wu7hDG46jfikQYLEr?=
 =?iso-8859-1?Q?n9/wHyhvlAMjqUC+mH3KQqx5VejNHhLcT27XOQbemgwzSGTNq+0y2W4Yzd?=
 =?iso-8859-1?Q?aiZ11+YEOEK5yR7v53xTQP/AVrBJ1skMb+K7NkBPXQvdNzXwXrsf3AJJid?=
 =?iso-8859-1?Q?vkgA1GON+PFJDWXMvKPvr6flNq2MOBU6EMn2qvPBV/ZgzYbiBnVdveuJhn?=
 =?iso-8859-1?Q?onISDrZB0GmcMePaKz39yyLrqwp2t5EQ0CuUqaJx4BkRtTktK8FfnFXPuC?=
 =?iso-8859-1?Q?dnzyDvLymIg++zeBtQIAMTb1aGYyBU69Oa03KRTEIV5H8ZOLCSp7WNsvYw?=
 =?iso-8859-1?Q?7a3hjQJbwo42MZmy1p+t4sa+zCatv8M90w5Vmy+hgy9LGt7eJNHv/MA4BV?=
 =?iso-8859-1?Q?x0mjFAEGfqo1opNqZJ2dNndpXRody4Nz2tfnPxcABwmwnaP4wVMc2e29Vi?=
 =?iso-8859-1?Q?rstheQoWFhbJ1NB/h2fCjDK5fjCIaZv7kYg0JgIBlI1O9iV3zlG+4PP9aS?=
 =?iso-8859-1?Q?gwxLtHeRb1JjmM3XDktYAL8GK//VfWmodOBseos5i+s2LWYM7GPAtxFKwk?=
 =?iso-8859-1?Q?OXz9ylvE3oSQYLx5+VN8VtnbQMU3tKY3i1lwLI+dtaHA9mhdSrcOZBAh7D?=
 =?iso-8859-1?Q?CiyNsXF9OAOqHIVDNJ1t7HWF8wPpT84y04+r4n4S/mQzQicVECvdwWHW9A?=
 =?iso-8859-1?Q?5n3EgE26UhIa77b7WGw3QlJKYnD+Ebmo8HkoeuIFO8R97eYDukP4VsUxbg?=
 =?iso-8859-1?Q?Zj5P/q4JB9VCjFoAuj8e8FGmDT6DuTTpBxjsxbY+O/Kef/auL6Eo5TWzGj?=
 =?iso-8859-1?Q?QSypnGAqcEfwiKGxpNrA0/fDWhchRTNzf1xUsRdeIhzCl0T7MWAmyDqmre?=
 =?iso-8859-1?Q?xN8wEn0Xgivs3ULl/fqkuG/reR8kOv8FHT3QLcHnwU2Uf7jVIepcm4Wx3M?=
 =?iso-8859-1?Q?I1Cn7D19nqyecMjyInyyrYN2yZeFKQqixvw5zIP7LCKYDLtXS3u0kli8L8?=
 =?iso-8859-1?Q?I7P4yzL0KYpmV9YjrXeW8wkAX/vgommZfchNXtuBArwAI6kFgijusZ3G+5?=
 =?iso-8859-1?Q?X5V94SL+SSyZkZJXpJsNEN5Dv3t96nxIyy5Sf5ixqf1smqBlOKL3uv36oK?=
 =?iso-8859-1?Q?3UutpumBjFgux+OHw5nyCZ2dzCIu/9WsBwYOR83wyR9K61CxW6HTn5UCuN?=
 =?iso-8859-1?Q?VnvnXtIuQm+FmyXb7bc2QKQDUlYyN/QRjSpCjafEGH1/SneQZc6jr2lYgu?=
 =?iso-8859-1?Q?WU1UtaupTSLKBwZN7TtXKw0zBFY2OXUpr9X+luj6X2AkwzG0AAgbpC9ozV?=
 =?iso-8859-1?Q?scZJ4zloXamRyqR5NfhfyIp8bAqqTb+p4hcm7xRwOSfmY6+Vv3RkyY/SQE?=
 =?iso-8859-1?Q?mVgYr1ucEmy8QfQpBraQtvwOM/osL/DW4fusr/SdmeysO3RSM1HSs2wSwd?=
 =?iso-8859-1?Q?+tQAqUdnitrJuVyA8sxEb10oRTYzWECEP3vk/vDsQWdPQvM0R4ac7Oex4o?=
 =?iso-8859-1?Q?U52OjKMphW+ZKOzaCObX3sumYthdCfMzvFDnMyeJeY8nkYgtUs2MLdxgIy?=
 =?iso-8859-1?Q?Ahrzx+zxiM8+UnayQKjJ0QN/PUoCDaZDrL?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4615.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58bbcb96-0fe6-4d3f-332e-08da83a1e899
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2022 18:21:04.1517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eCj3cIgDYmR2cUXriHbeXZmoXZmh/uQ/wOfYI1As6we5H4JbyW7D031DUi5l8zFK8XnFxeG/9Etw39BqAcMoqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3330
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What happened with this patch? Looks like a important fix but I don't see i=
t applied ?=0A=
=0A=
  Jocke=0A=
________________________________________=0A=
From: linux-mtd <linux-mtd-bounces@lists.infradead.org> on behalf of Yifei =
Liu <yifeliu@cs.stonybrook.edu>=0A=
Sent: 03 August 2022 17:53=0A=
Cc: yifeliu@cs.stonybrook.edu; ezk@cs.stonybrook.edu; madkar@cs.stonybrook.=
edu; David Woodhouse; Richard Weinberger; Matthew Wilcox (Oracle); Kyeong Y=
oo; linux-mtd@lists.infradead.org; linux-kernel@vger.kernel.org=0A=
Subject: [PATCH] jffs2: correct logic when creating a hole in jffs2_write_b=
egin=0A=
=0A=
Bug description and fix:=0A=
=0A=
1. Write data to a file, say all 1s from offset 0 to 16.=0A=
=0A=
2. Truncate the file to a smaller size, say 8 bytes.=0A=
=0A=
3. Write new bytes (say 2s) from an offset past the original size of the=0A=
file, say at offset 20, for 4 bytes.  This is supposed to create a "hole"=
=0A=
in the file, meaning that the bytes from offset 8 (where it was truncated=
=0A=
above) up to the new write at offset 20, should all be 0s (zeros).=0A=
=0A=
4. Flush all caches using "echo 3 > /proc/sys/vm/drop_caches" (or unmount=
=0A=
and remount) the f/s.=0A=
=0A=
5. Check the content of the file.  It is wrong.  The 1s that used to be=0A=
between bytes 9 and 16, before the truncation, have REAPPEARED (they should=
=0A=
be 0s).=0A=
=0A=
We wrote a script and helper C program to reproduce the bug=0A=
(reproduce_jffs2_write_begin_issue.sh, write_file.c, and Makefile).  We can=
=0A=
make them available to anyone.=0A=
=0A=
The above example is shown when writing a small file within the same first=
=0A=
page.  But the bug happens for larger files, as long as steps 1, 2, and 3=
=0A=
above all happen within the same page.=0A=
=0A=
The problem was traced to the jffs2_write_begin code, where it goes into an=
=0A=
'if' statement intended to handle writes past the current EOF (i.e., writes=
=0A=
that may create a hole).  The code computes a 'pageofs' that is the floor=
=0A=
of the write position (pos), aligned to the page size boundary.  In other=
=0A=
words, 'pageofs' will never be larger than 'pos'.  The code then sets the=
=0A=
internal jffs2_raw_inode->isize to the size of max(current inode size,=0A=
pageofs) but that is wrong: the new file size should be the 'pos', which is=
=0A=
larger than both the current inode size and pageofs.=0A=
=0A=
Similarly, the code incorrectly sets the internal jffs2_raw_inode->dsize to=
=0A=
the difference between the pageofs minus current inode size; instead it=0A=
should be the current pos minus the current inode size.  Finally,=0A=
inode->i_size was also set incorrectly.=0A=
=0A=
The patch below fixes this bug.  The bug was discovered using a new tool=0A=
for finding f/s bugs using model checking, called MCFS (Model Checking File=
=0A=
Systems).=0A=
=0A=
Signed-off-by: Yifei Liu <yifeliu@cs.stonybrook.edu>=0A=
Signed-off-by: Erez Zadok <ezk@cs.stonybrook.edu>=0A=
Signed-off-by: Manish Adkar <madkar@cs.stonybrook.edu>=0A=
---=0A=
 fs/jffs2/file.c | 15 +++++++--------=0A=
 1 file changed, 7 insertions(+), 8 deletions(-)=0A=
=0A=
diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c=0A=
index ba86acbe12d3..0479096b96e4 100644=0A=
--- a/fs/jffs2/file.c=0A=
+++ b/fs/jffs2/file.c=0A=
@@ -137,19 +137,18 @@ static int jffs2_write_begin(struct file *filp, struc=
t address_space *mapping,=0A=
        struct jffs2_inode_info *f =3D JFFS2_INODE_INFO(inode);=0A=
        struct jffs2_sb_info *c =3D JFFS2_SB_INFO(inode->i_sb);=0A=
        pgoff_t index =3D pos >> PAGE_SHIFT;=0A=
-       uint32_t pageofs =3D index << PAGE_SHIFT;=0A=
        int ret =3D 0;=0A=
=0A=
        jffs2_dbg(1, "%s()\n", __func__);=0A=
=0A=
-       if (pageofs > inode->i_size) {=0A=
-               /* Make new hole frag from old EOF to new page */=0A=
+       if (pos > inode->i_size) {=0A=
+               /* Make new hole frag from old EOF to new position */=0A=
                struct jffs2_raw_inode ri;=0A=
                struct jffs2_full_dnode *fn;=0A=
                uint32_t alloc_len;=0A=
=0A=
-               jffs2_dbg(1, "Writing new hole frag 0x%x-0x%x between curre=
nt EOF and new page\n",=0A=
-                         (unsigned int)inode->i_size, pageofs);=0A=
+               jffs2_dbg(1, "Writing new hole frag 0x%x-0x%x between curre=
nt EOF and new position\n",=0A=
+                         (unsigned int)inode->i_size, (uint32_t)pos);=0A=
=0A=
                ret =3D jffs2_reserve_space(c, sizeof(ri), &alloc_len,=0A=
                                          ALLOC_NORMAL, JFFS2_SUMMARY_INODE=
_SIZE);=0A=
@@ -169,10 +168,10 @@ static int jffs2_write_begin(struct file *filp, struc=
t address_space *mapping,=0A=
                ri.mode =3D cpu_to_jemode(inode->i_mode);=0A=
                ri.uid =3D cpu_to_je16(i_uid_read(inode));=0A=
                ri.gid =3D cpu_to_je16(i_gid_read(inode));=0A=
-               ri.isize =3D cpu_to_je32(max((uint32_t)inode->i_size, pageo=
fs));=0A=
+               ri.isize =3D cpu_to_je32((uint32_t)pos);=0A=
                ri.atime =3D ri.ctime =3D ri.mtime =3D cpu_to_je32(JFFS2_NO=
W());=0A=
                ri.offset =3D cpu_to_je32(inode->i_size);=0A=
-               ri.dsize =3D cpu_to_je32(pageofs - inode->i_size);=0A=
+               ri.dsize =3D cpu_to_je32((uint32_t)pos - inode->i_size);=0A=
                ri.csize =3D cpu_to_je32(0);=0A=
                ri.compr =3D JFFS2_COMPR_ZERO;=0A=
                ri.node_crc =3D cpu_to_je32(crc32(0, &ri, sizeof(ri)-8));=
=0A=
@@ -202,7 +201,7 @@ static int jffs2_write_begin(struct file *filp, struct =
address_space *mapping,=0A=
                        goto out_err;=0A=
                }=0A=
                jffs2_complete_reservation(c);=0A=
-               inode->i_size =3D pageofs;=0A=
+               inode->i_size =3D pos;=0A=
                mutex_unlock(&f->sem);=0A=
        }=0A=
=0A=
--=0A=
2.25.1=0A=
=0A=
=0A=
______________________________________________________=0A=
Linux MTD discussion mailing list=0A=
https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flists.in=
fradead.org%2Fmailman%2Flistinfo%2Flinux-mtd%2F&amp;data=3D05%7C01%7Cjoakim=
.tjernlund%40infinera.com%7Cb544edff033b48e8098708da7568ad4f%7C285643de5f5b=
4b03a1530ae2dc8aaf77%7C1%7C0%7C637951389689871127%7CUnknown%7CTWFpbGZsb3d8e=
yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C=
%7C%7C&amp;sdata=3DNLesT9SYnUR8pO%2BDq0YW3hoGUbTdlmHQO3cVtqS6H%2Fo%3D&amp;r=
eserved=3D0=0A=
