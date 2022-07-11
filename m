Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA0956FFD4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiGKLNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiGKLMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:12:52 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2021.outbound.protection.outlook.com [40.92.99.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9868583F37
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:25:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETaxQ2rG7WjlZ1j5AqAWNYXMG6iNKb5pg7YLUf2OFssa9lFSi2tJyoXaFhol+xKq6SMItesTGQyxVeb/eY8wbHjyV/7hdAkkGyW8BvF3PpdL40JEyxduJ+6S82PFpSdauHEhSDyl3v9cLEwDCu75qYe/Ic5lLSR2E1vgjK04woY8et1HlqzzAoVhMcyExmhQqCtNc/Xn4fvH82waFEcKZjhXVkegcynmv+HjT3w+oDV8+xfktmldR7n/TqyO6EcDbR/IsA1tIfRf2A11XA9Vai6/x7r3nOndNT2yf8maLcWtgIhzW7MQdatQe8o8q17x2eAdbLdaqcLLs8lLyb6Otg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHZA5v+NXRrkqH8uxEGKYmNqaKSIJCbT6XfkIbDflVk=;
 b=ogAKPP6HlfR/PMmn0tLEmWTlij+oiWeXp0LjeuQYFtL4eEd5BDhVt6ePHlrk3SWPILHz+ar6cDW1QxKaciNgJG5rLv/d5/qx0FvT2RAmBepRQ6xnD/wTp2xzjRqFRA2gO8PCTowAfCJbOW/jWevZ3uNPQtl9PLygBhHqHmu7Jy/78dd20WGylZyv1rwi3WP7ISkcUGv4VGP2b0e8SI94dV+BlUg1X48MF8WLTZV7Icl5xemM4/xVqXvLP7uoeKUWCxiA6mIqAWCP+FWEutC0OBa5hx/SR+5cKDaNo+xlc/W7HVbFsVLgkNST3k2DTULU0niD58tFbnK8cHhr1MMrmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHZA5v+NXRrkqH8uxEGKYmNqaKSIJCbT6XfkIbDflVk=;
 b=HGkgwdSkaALLTgfFh26q73Z3qs9dM229e9YCpC2Ys0au3P/2FG07poDB6Te8APrTTyp69y22/JwQ8j1zXfhz+5nhGe5yid6iLPeBXZrdZSPBcxOe5rwvUlNiT3OlX7H/mdZIsMghCBysu85CXUT6kKhD+xqQlbI7F53yjd+Nitr8WxlXpka+xcT59bDTqkR6LUMCM0h42O9z8fKg8sxH3imD5/Oa2tdx6H6qYHZG4XfCvVVfr4aY0g+lT84RXAq5HmfB18jvmhZjsCWoI4B132GoD/Bd6IXV4dmNHm46QGwJq4f3l0ZBAEhA+Ys42Li3cR3ZTu47IoghsLoJnM99Yg==
Received: from OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b9::12)
 by TYWP286MB2828.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Mon, 11 Jul
 2022 10:25:36 +0000
Received: from OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM
 ([fe80::5999:44e0:89f9:487d]) by OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM
 ([fe80::5999:44e0:89f9:487d%9]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 10:25:36 +0000
From:   "anquan.wu" <leiqi96@hotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, "anquan.wu" <leiqi96@hotmail.com>
Subject: [PATCH] libbpf: fix the name of a reused map
Date:   Mon, 11 Jul 2022 18:25:21 +0800
Message-ID: <OSZP286MB1725A2361FA2EE8432C4D5F4B8879@OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.32.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [cA8xopi+Vv4OKQesrdq5ig1NtTyERmpw]
X-ClientProxiedBy: SG2P153CA0043.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::12)
 To OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b9::12)
X-Microsoft-Original-Message-ID: <20220711102521.2880073-1-leiqi96@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0153555b-10b8-4441-4680-08da6327b173
X-MS-Exchange-SLBlob-MailProps: tBYDyRQCPclOIkD59KsepkTwUEhbPdiPZ/dugKQ5UMr31Vce6z3pFwEyaK4EoX06phBsw8FjBRISCfMnd1Ca/Zmg/XRORU5q0j3GKKtc7exd/Ffdm8iPRSG4dU/GZi03TkPEJdZIfqmW1bMNLHKL3tvXktOK8jFW41YYlLTA9X85fV0t8sGEB9oFXWuFJpR6trFAOpSXW/tyTtCxbOkr6cyDv6dsvOwhbZX1QnNSLXfF0/LpztG2ZYzoEocJpHKqbSfcA/nD8q2DfKyDpNewNKO3FYthxsEyrHcgL8ytHbin7Yl0+pPFzsw/zBLmDfgbj2kqnOsek00ovrLDUaGGKiVzuVyWucIf+/PzizFoRldu7KECIRaehpJ8Iw2pu+IbrrApyxecYgl9ukUoC+xmglI01CnBmMAZ9JVEgeNGRVVdRQmzjK0r+iUwH8RK+uVBXpHET30RIsMaVkW9pa/PzJj7yjnaJTQaLvYNLSPM9iMCDvpGiUn6saOWQfkN6SDXPlgqXiHBuVTaRnjbJ9qV5uY+vRi1S+W5SPtyl+AgcYChjd6URfFIxmCroVOjQFG12I2n95q+vJZPL5mNolZ3XdRNKQeSuob0oqzFRhkgbGcjTqqt6gRXgDa3ujW1vQVDRmiqlSS/1aeSZ14BYqKmwhw4JyejpvVTWQUzWVtU/qtvUZA/LQzG8mxuIpfV38eo5Q3COJSzqwDkWwwcB07pdnqi1ITaZI2j4q+J9hllUqaDhKv90CpwOFWIV/X4kokPl1stinD8Gsk=
X-MS-TrafficTypeDiagnostic: TYWP286MB2828:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ej4+X/pUL2MhmlgUBPhOfRe4yAwZ4lXjJUaZ415WZZUhl9BMo8OG4l6VBg1/rxtvhjeZcsS/uuWIo2hJlCfotEMDZCJf1CJV4RgJpPq0PP15X7V53P3CfDxnmnqQTbrWCVDxApz8HuVDYyHfxUD+UrVV68WN00wdEyPL213R2DgR+/9/u3HD1ZlFRaxYp0Jr/uqes2DYB8tSqt2+nHgy8iC3AG3j7O+hU/+BBLYAIbA/jMAUpoRuWUXmOABxDp35UrX7WpszuoHarqBRrE7FH0DR2DnuNLFP1GvcAz0plGvIIdBP25Lx8R740KUjvp0Npt/F9iFxYXXaZWXSEBrTEUaEwhkEQK2ubXT9xHpvs+cPIS3sZTLUWxBmBVon/7T3HX7U8XQ9Ig/eiyVULqqwpmA1s88HQf7HWIggZjPdL7rSX+qeUKRinwXsVL7nLLz30GF2YuT1s7pJrUCTB90A7trny28Cmkt9s2GhTU6WPloIH1TZPuvcV/MDLm8fPMjH/rfMiWkAk2vedBVgxwD2KY3sKGcd+lcGgIKRqENFORNNReiHor3KJ7Eo+c2PKxUpnON8jGGpDIX2hMLqrSoPBOcNYXVQ849OMw1WFZAK3zuy1+mIKecKYmUnvNriZqo22mPhxWj34S9Xkx1ZCA48huHq4NGgz+Lw6hDZc52DMW4rm9qxXyF93BhbHAPPCpM7aiGURfK5l9YOyzQnxRtduQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlhLZ0RrUU5KdktZSjlLQWJtbzJVRjZVL01rb00xcUFBNDRQNTNSWDZDTVlN?=
 =?utf-8?B?cDhBeEVXWWQ2RUJJZXI5dDB0ZkZ1MnYyUWRrR29oUS9QZHZidzMyeUtqeHNZ?=
 =?utf-8?B?enVIZ3YvOXNQam1tWVorZ3QybVVqSGN5ek5aVno4ekJQL2FpMWk3bHVSQU4y?=
 =?utf-8?B?UHRpN0psdHNDM3p5TnNuR2QrYWFmZmNNeHlaWWZPajM3WENUQnhMNU5SMFZ5?=
 =?utf-8?B?d05IaGwwMEZQV2xnUjVSOXZBOENZdFlKcDBaUTVjZStxOHl3SEVEa01sVjg0?=
 =?utf-8?B?VGZyZGxiaVhIZWYxei83YnVsOVJLSXFXVnVvaStZazg0eTlSZlFObXQvWSt5?=
 =?utf-8?B?T0Q3VXRLa3U2cmVZekdNbmswWU43Mm1PTHk4dlJSODdLcnAvVWNJeUZvTzVV?=
 =?utf-8?B?M0lpRUtvUXlDK3hLVWRLb2UrRlJPWmt5N092K3VzbDlHUC9KQWxPVXRjOFRJ?=
 =?utf-8?B?bEYrOGM2T1JtMExZNkVVakcvREdwMHYzZ0RNWFB5cEZ6WnJnSHdvK2ZPKzlm?=
 =?utf-8?B?c0FaZklJZ0hpU0VuaDlULzBFU2tXUFVMZnNvS0k5YnlKWVdXNFkwQ2I5NE9t?=
 =?utf-8?B?WkdzcGVmenlvZERSZllIQ3dBZ2l4ZkU1NFpnRnlTN0FURVZvWDIrQVY4REdO?=
 =?utf-8?B?SzhtZGFFTENZK3BVdGtmTGxXSXZXNUN5Y0ZjUkRyVk5IMkZDbkt4alZ1c2Zi?=
 =?utf-8?B?T0NVWDhzckdLbXhicnBaVVFDQktuWkl6OWM4SGJoNG45K0piZGtEdk9nQW1Q?=
 =?utf-8?B?a2xqSjdENW94U1I0L2xOTHhZUEkrV3B6TitqZXhNbTJiWmRTNFJHTzVUMmVL?=
 =?utf-8?B?NVNNeDZzMDgxRVhIdzE5TkdQa09UNkRrMEQ5REFkbm4yblY0ajNrZGx2SDFO?=
 =?utf-8?B?MWNzdnFEOWF5MXdYaW44eVZiOEZsOXhlWXNNT3ovYk1ydnIzdy85ZlJ4VWtS?=
 =?utf-8?B?UjI0K3Y3bXNtMDZRRkNMVzFnS3ppNitPT083cDdCdWZoV2RnVjEzMjdmM2Uy?=
 =?utf-8?B?MVA1YUJBcHBkV1V4MDNtS3YvTENzd0s3aVNKajduazNXMmd6Zk5RcTBCc3h3?=
 =?utf-8?B?SkZENEpJVU5nVit4elZzUnNxeXJaUmFxQnVvR25OZHJIVFQvbVF1aFBrMUxp?=
 =?utf-8?B?K1Q5T2dVM1RlcnJpUUpRdWtlTGpFaWZ5amY1QUlJcUxpKzIyWkVpRW8zVG9o?=
 =?utf-8?B?a3FuelVoOHJkVFNuWUJ4M3JyQzZRaWduL2NUekY5bnhjbmVxTTRwc3NXaHVy?=
 =?utf-8?B?U1JjM0ZyWW00ME5iNkFlb2o5NElkaTJKOVB3MDNQMitQNzY5ZnI3eENWQnl0?=
 =?utf-8?B?c0dDMXNZckJMYW0rd3BQNEdtTDdLaExFWEp5WEpPQUh1K3hyWTB6UWNFTDY1?=
 =?utf-8?B?a3FuMlgxaVB1L2RlZUo4ekpvUVF2L1pmTFFBVTB4MjI0Wnh4cW1JWWdZVzdP?=
 =?utf-8?B?MFFQcC9iKzlzTnhNdXR1a1RIR2Y1RkdJMVBhR1N0bXZnTTBlS3BJb1A4ZDFa?=
 =?utf-8?B?eEhZR2ZWYjA1MG9tdmo2Mjc3bEIyYUZvN0RXbGJuaFZhQ3VvUnB6VU9zdDFD?=
 =?utf-8?B?WTEzSGYzYUpEcXg5bllYNHcrMmF2dXNGYmF5enV5bDNiMDlrOXBaUzlFQW5n?=
 =?utf-8?B?VkhsZ0NjWnk0bnV2enpxbnhxUmpOWWNqaS85TmtIRHNhTTZ3UzlNZ0lNcWI2?=
 =?utf-8?B?c2pzK2hpd3JrS1NYck56QVlnWGhWejd1ZExmcWNzMWVrbjNnc2R2NDV3PT0=?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0153555b-10b8-4441-4680-08da6327b173
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 10:25:36.1456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2828
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BPF map name was limited to BPF_OBJ_NAME_LEN.
If a map name is defined as being longer than BPF_OBJ_NAME_LEN,
it will be truncated to BPF_OBJ_NAME_LEN
when a userspace program calls libbpf to create the map.
A pinned map also generates a path in the /sys.
If the previous program wanted to reuse the map，it can not get bpf_map
by name, because the name of the map is only partially the same as
the name which get from pinned path.

The syscall information below show that map name
"process_pinned_map" is truncated to process_pinned_"

bpf(BPF_OBJ_GET, {pathname="/sys/fs/bpf/process_pinned_map",
bpf_fd=0, file_flags=0}, 144) = -1 ENOENT (No such file or directory)

bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_HASH, key_size=4, value_size=4,
max_entries=1024, map_flags=0, inner_map_fd=0, map_name="process_pinned_",
map_ifindex=0, btf_fd=3, btf_key_type_id=6, btf_value_type_id=10,
btf_vmlinux_value_type_id=0}, 72) = 4

This patch check that if the name of pinned map are the same as the
actual name for the first (BPF_OBJ_NAME_LEN - 1),
bpf map still uses the name which is included in bpf object.

Signed-off-by: anquan.wu <leiqi96@hotmail.com>
---
 tools/lib/bpf/libbpf.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e89cc9c885b3..5ad52a8accd1 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4328,6 +4328,7 @@ int bpf_map__reuse_fd(struct bpf_map *map, int fd)
 {
 	struct bpf_map_info info = {};
 	__u32 len = sizeof(info);
+	__u32 name_len;
 	int new_fd, err;
 	char *new_name;
 
@@ -4337,7 +4338,12 @@ int bpf_map__reuse_fd(struct bpf_map *map, int fd)
 	if (err)
 		return libbpf_err(err);
 
-	new_name = strdup(info.name);
+	name_len = strlen(info.name);
+	if ((BPF_OBJ_NAME_LEN - 1) == name_len && !strncmp(map->name, info.name, name_len))
+		new_name = strdup(map->name);
+	else
+		new_name = strdup(info.name);
+
 	if (!new_name)
 		return libbpf_err(-errno);
 
-- 
2.32.0

