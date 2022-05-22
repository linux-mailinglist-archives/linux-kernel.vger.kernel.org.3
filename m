Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAC75301EF
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 10:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242057AbiEVI5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 04:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiEVI5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 04:57:42 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36243FDAB
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 01:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653209860; x=1684745860;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G5+4rscONIhG5vVdjFzi7fHQ8fXcbe5d465rNf7CvYk=;
  b=lfUqEyBEm8Fc/DyrEVr+8JlxH462uzUwqLdMDm0Lo85JxULlZBRigWM3
   8QsKeIQkF7eTqhPxmJ1KczTFxKRXqzzWsMv/C0+cgYuj4q5mlOdiTeL56
   jmiio8ftN7u9vRmUDZc7clD+KgjvAEExSIjIlOJVZFlSSP2Wh3IXwPT/t
   yfEJEMaeWUBHiWBiMB/gqQ9XmWyrYpjHiIIMso/0U1w0X3dUy2sG7RbZ/
   /ErxReK8t7PPrEbB5e9yEL1WL+kQuI/hxz+w2FLADhFYRab5fqjnQmvUt
   ZjUkwucJop9GQtjRRpmHHa6dNI1A/jPNMojaSTTVXrYbAOWs3r/pvVc7x
   w==;
X-IronPort-AV: E=Sophos;i="5.91,244,1647273600"; 
   d="scan'208";a="313046358"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 May 2022 16:57:40 +0800
IronPort-SDR: mgF3fzMoj0biCYP5BjaX2IlQ3kB/AlfkmVS5pldOZ2esHpyzFkYd+w6OJK1tgS/4Hlkt20b4cY
 8qr677S0EyY9YFuFWGOUIFTQrh3KV3lcBpIUSWoj4M9Z7vhkJyzykl9ry8KGTVlotwhS85PDSn
 1Wi5bjeySvht4IjmIwOLlTutoztvGimPsS6SjvbTVzv/TpZ1wfO09vk8vt1toJcL4UHkpWdIgV
 569o3yOXSIEHHqIz0id5eQrvajaIkUiemyzSNZm4V9BG0BP434RVcKqQkHPNXd25noIUAPEuis
 Rd5nd0xJJShaRsWImeOxYXss
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 May 2022 01:21:41 -0700
IronPort-SDR: N7E+rCFpfMaGWlVKlGIE7YomLUY65EsbuQz1b/aQW0kBGZreaRkxyzb75j1AdLMgdX4vTxO0xl
 R3LuxWr2SGSXdRoei7gm5CryXVR3mzc0T+UGIGqWzjvQgyk5EbIBEci+kfWGJDLQ89mMQpr1TV
 R7k3yzSUToTYVc/bNfIAvwVkEx+41u5cS+l39SNVrvZxfN7eMPOqTpMoVaaTOsJVPKGYHc4w6W
 N11Co211TxKZLQQqXFcGa53+IjJIC0t8d4/3nNXw9nH4CND7TbtQA+zl7z+dpP0YFZEdAUJe2M
 QXE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 May 2022 01:57:40 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L5Z9H4nnVz1SVp5
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 01:57:39 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653209858; x=1655801859; bh=G5+4rscONIhG5vVdjFzi7fHQ8fXcbe5d465
        rNf7CvYk=; b=pZvIrPItFbCSSksFipwO6soign0J4ZbSXjZVDPLF1mxgU7HoG6y
        Qes7nT6CCQ4EhTqcnR2oZdmis4YLHMS0BhcC+I2Ms+NfIXZ4Rv1d9FLG+ss3DuRm
        CVchfne/rs4uPAGvJXyyp8j4EoRTWMPhUIJmEHYxc8cmW3Fy1mRW6U2uehQ2hDBD
        bZKpv1i1ZFn6wTrMWnfeUl1r5WRRMkorVCtfNZruWJRQugdLqWaoP+BqL7fWmIZQ
        0VD1fppWF/N9ETROkL9Id4vKRra+GjCsY9J0QF9jr+j4XlkI2weYJz4LKzYiMWMG
        SSwcKgg/RGD/ps3Bs9I9BBtklGd5H8G4PUQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nnEJmRbHHtkR for <linux-kernel@vger.kernel.org>;
        Sun, 22 May 2022 01:57:38 -0700 (PDT)
Received: from [10.225.163.51] (unknown [10.225.163.51])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L5Z9D07Fnz1Rvlc;
        Sun, 22 May 2022 01:57:35 -0700 (PDT)
Message-ID: <54be2e4a-29e4-04f9-2b73-7705d595d6a6@opensource.wdc.com>
Date:   Sun, 22 May 2022 17:57:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3] RISC-V: Add CONFIG_{NON,}PORTABLE
Content-Language: en-US
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        linux-riscv@lists.infradead.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        rdunlap@infradead.org, Arnd Bergmann <arnd@arndb.de>,
        anup@brainfault.org, alexandre.ghiti@canonical.com,
        Atish Patra <atishp@rivosinc.com>, axboe@kernel.dk,
        guoren@kernel.org, mchitale@ventanamicro.com,
        linux-kernel@vger.kernel.org, linux@rivosinc.com
References: <20220521193356.26562-1-palmer@rivosinc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220521193356.26562-1-palmer@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/22 04:33, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> The RISC-V port has collected a handful of options that are
> fundamentally non-portable.  To prevent users from shooting themselves
> in the foot, hide them all behind a config entry that explicitly calls
> out that non-portable binaries may be produced.
> 
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
