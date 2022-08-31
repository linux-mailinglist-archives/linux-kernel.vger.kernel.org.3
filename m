Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36855A80CC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 17:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiHaPBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 11:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiHaPBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 11:01:08 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70050.outbound.protection.outlook.com [40.107.7.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DB67C329
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 08:01:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jk6WP1mfFw0YHyl3GXT3y90bUNOnjRyLnaVUFj91OLJx1ega1ck8suqpZa0WySkW8Azj9mvVRgISM7M8+YyBafYwX4yTJgKRq4+Atv+2AHf46HeubzV1JMDFR9Qw/kgayml2WoG6XLhHEdW116M4UdPijfaXFN9nsWBqqzpO+0gcJGvYo3HGGTphjiAh9OsGSlvTJdvdZag2eeYzoMWBXiMjVpdrCmjMjlPGEFSxUhBou7XCwifoxrm4K3SRNxWHuGNcnU0chsaxw/9qEAiR0JLRdDCZ8sdwjkpxnWddUBI7UBUyPsInTO3E7STVmLgCDdB9VGk0pJO+stQutWyb4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfKaMFn5J30mvvk7dF9YSa8Kn3JQOQrhEMvGMsQb2dY=;
 b=iE9jYkTdVbSASQz4q7XVE9zoW1kHUNj6sdYd20zciQ9I7DiXu1hrw3+4SSvfHsBUeEjze4E2MwNWNhwjndHGE6mStY68kjrd1md3E4ur+t2ujAeBwQuWOyLtup0gM/VeMZ0PGeyWT1Linuvkmn1Z9lpCvrMM9oMuI7sCiYw8FdUDtQgGahykF8BP9oMO6GDa09518VhtnMljfqnR+RZDEJ7Sl5+RYvRM6Muk3wa3NcqOlsrWnhY0tIZBj+Ar2NM7abeMKOofkROM08E83384C8Szj5ksoKQMxGLWE+59m7wStN1lWEIjRICDIOyEJ5ZuwGKvwhEELY6EW6oZNbTMYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=hotmail.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfKaMFn5J30mvvk7dF9YSa8Kn3JQOQrhEMvGMsQb2dY=;
 b=omlE7K/Kt9y+/8T6UdzzM05tDoWDbERrlQTXWFUJS+SMkTNKK76OQyRTfX0rhYWI80ssfIX1X3yYc3k33GfyeIYvpWuZTqJe+zpzN3UcNcDkpvUzi5sNy+whQBhj/1/gKKWTgXr0WNEy/KLMSKj4yS4LezgAwFXT/AtfY0b7v46ioqOv5jbJXofSk/jCKfxmuFhCQQCaU37dhTrPfHPz+xi8UeHII8u9qXWYyywiHr6LW1I62vqowoWn25Dh41sfA+gHDjabRFFsW7+aWp4I6sKWXlRSZ6AgtZZoYdMFlHMQqeeQM9krxSXkNcyASjyNV8vVxHA94uKzCdOF48qxwA==
Received: from DB6PR0301CA0096.eurprd03.prod.outlook.com (2603:10a6:6:30::43)
 by AS2PR10MB7228.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:608::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 15:01:00 +0000
Received: from DB5EUR01FT075.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:6:30:cafe::2d) by DB6PR0301CA0096.outlook.office365.com
 (2603:10a6:6:30::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21 via Frontend
 Transport; Wed, 31 Aug 2022 15:01:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT075.mail.protection.outlook.com (10.152.5.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10 via Frontend Transport; Wed, 31 Aug 2022 15:01:00 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Wed, 31 Aug 2022 17:01:00 +0200
Received: from [139.23.74.152] (139.23.74.152) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Wed, 31 Aug 2022 17:01:00 +0200
Message-ID: <52c33fc7-220e-c05e-3ad9-028095d8705d@siemens.com>
Date:   Wed, 31 Aug 2022 17:00:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/3] scripts/gdb: fix lx-timerlist for struct
 timequeue_head change
Content-Language: en-US
To:     <pngliu@hotmail.com>, <kbingham@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, Peng Liu <liupeng17@lenovo.com>,
        "Stephen Boyd" <swboyd@chromium.org>
References: <TYYP286MB17634911E6C6951ACD128342C68E9@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <TYYP286MB17634911E6C6951ACD128342C68E9@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.23.74.152]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--14.394000-8.000000
X-TMASE-MatchedRID: 0ayLSLUekQXrOhfRe676R7VjWRIm2MckPWKLA6/g//vx5KZMlKYS/bDm
        wsUzv3A7GFuT8Dlyd8smgo5BSqf/nq3aC25avUuayCTsSIAWZKdmpjq3pYgD4nnNctcK7zfFfpA
        HEtIudzBwkdIrVt8X1WBt9mS7pKVTeoqVs1ZLrvCG184Y5LIraU1+zyfzlN7ygxsfzkNRlfKomJ
        wkWeWDXyuDS/XyqRdwjoczmuoPCq0wIPYySOiKVuegrWTIaiL38P6n//GkviZ05mztXHCYIcPWX
        8v2au7y
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.394000-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: B4781A729E6F0463C371F443D082ED21B3AE1B6CEFD924633208CB59535F74F02000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4530afa-e721-429f-148c-08da8b619e34
X-MS-TrafficTypeDiagnostic: AS2PR10MB7228:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ELiNs5o5CjNG0FzqD3oNYY4tieg1M9b45qsRkpoJWbf67COqnj7Z0CSHYuW0OPk5/Tts6cf48pcsKISdrLM5mSLgdixehjrGvqdTFqFwZJEEKIpUU5cS6VfFihiR5RCO43hrY3W65rUo+InRnNXbLUszXRdILQcO8u55H3Kao2rhWuXwXi3Jbzwgxv2+cuw9XtssK25bB+cQ9meOILpW+LqN/QXWCrM6bS8BBKvjuCumZYmspiLHKz3oxfmjJAIbLTJpIqbSl7eY4iXU4e/Smnvrr5IHbrs0lG4CzMzvJtjvF8drbo6d28Gu1who8XnHk+mdKWpQt9yagswF0LrbpV2Tzrrj8icgMfbaeR9HJWXIDEDOLQoEiogjKPja5WVFYWrQNLGeqhSjV3VuvtlCAXL4GSCKjYzmjmE40nNM1PqbQ37JrVyrrW5Gk04XxTP/wcQ58kEEWw+PwP+pDxPwTr1VlMMz3mrw1d4PpgKT7NWSfpLwzCqpAFWy8qhcC14u8KvDvh4aU+TfLyrUjf3di0pplydeuOv4qoNr7jFOaBcQgri+SY9sq+rE+0ND7YjiqutMZiiriGTBn8yZpnhLaBcwPN3M/xxMOHxzUM8SGp9+470rJBccDpgS+4rDvsXwFqHjFivNrESu71a1eQYQyplAwvEfxZ5730T7pQ7Lm44yxn7rxzeBVOEy618W2Qe5dsGoBbEqZKZ5uInip4hJOoGCH8ZUEXy6WPvRuwUFobOQ4DV/ZdP3C7ALuUJ3yYvrW1P9cxqY6iuJtGRbXYAudSJ9cenVaJWeAUcd5HHF/PI1oi+aRvEJTSjJ9qEENfPkgwXm+jX37GCfnEjtQC7xw==
X-Forefront-Antispam-Report: CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(396003)(136003)(40470700004)(36840700001)(4326008)(70586007)(8676002)(2906002)(54906003)(356005)(16526019)(186003)(336012)(70206006)(83380400001)(956004)(2616005)(45080400002)(44832011)(5660300002)(8936002)(316002)(31686004)(36756003)(6706004)(110136005)(16576012)(82310400005)(7596003)(31696002)(7636003)(478600001)(86362001)(82960400001)(53546011)(26005)(41300700001)(82740400003)(40460700003)(32650700002)(40480700001)(36860700001)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 15:01:00.7867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4530afa-e721-429f-148c-08da8b619e34
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT075.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7228
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.07.22 14:27, pngliu@hotmail.com wrote:
> From: Peng Liu <liupeng17@lenovo.com>
> 
> commit 511885d7061e ("lib/timerqueue: Rely on rbtree semantics for next
> timer") changed struct timerqueue_head, and so print_active_timers()
> should be changed accordingly with its way to interpret the structure.
> 
> Signed-off-by: Peng Liu <liupeng17@lenovo.com>
> ---
>  scripts/gdb/linux/timerlist.py | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/scripts/gdb/linux/timerlist.py b/scripts/gdb/linux/timerlist.py
> index 071d0dd5a634..44e39dc3eb64 100644
> --- a/scripts/gdb/linux/timerlist.py
> +++ b/scripts/gdb/linux/timerlist.py
> @@ -43,8 +43,7 @@ def print_timer(rb_node, idx):
>  
>  
>  def print_active_timers(base):
> -    curr = base['active']['next']['node']
> -    curr = curr.address.cast(rbtree.rb_node_type.get_type().pointer())
> +    curr = base['active']['rb_root']['rb_leftmost']
>      idx = 0
>      while curr:
>          yield print_timer(curr, idx)

Looks good to me.

Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
