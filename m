Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4552495703
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 00:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348074AbiATXd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 18:33:29 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:29545 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348050AbiATXd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 18:33:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1642721608; x=1674257608;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bbAUjyI63AzHMI4JG4Nlo6/VnP4NtE6QUmV9m2+5F70=;
  b=SJ9ktjHBzI8rd4qlJ+b3FJvWNsheitWeL66v0MDbRyZUD0L/kc/GjBpc
   TsJbGVXesvdhq8z78vGWpxykAiUUKhiKG9rI0bYnZXSTkgghSBkluuLOm
   f8h6emAZF6aXshR4AGCbVPNlSF+cu4Vgyu56xgOtKpsbwdAkZyLL2xD6A
   4N/7/LYaxyI5Y36efthfI/BykjW1ZiixmnxlOzrVAJlYljXFXz+fQPPeE
   fiRgAiJNcFLQju5KJPChI35OyHdyL/bE911Nl+eLHH4ODjuhvx6XqiO2T
   TjAI69Rx48LBFZbrI2oG1deA60Fou7gyYW/oz/ncX7+Ye20lG+5C585Oo
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,303,1635177600"; 
   d="scan'208";a="189953454"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jan 2022 07:33:27 +0800
IronPort-SDR: /I2qY9QghxKkHfWS0bh7ziSdDsiHOEhFA5qTc+/mXtTtIXkLwWT6OnbAl78dT49Of8Tr53/wQF
 D4cwfkpWci66Q58kD57ZV0gauSk1EmAsepbYoUBPj2xdyE37LfQnEZ/m8kewhyLbYVFw9kLfSo
 FQTH2CkjG7bLdyq8yISIopdNzu00Dl27t5oA4ZQIJ/PIS35NkM0Rv9XVDT6x9YVb8RAJHIPFRt
 qiXY3QOBBSKaOpsMNGd5q4cN1XNpvlGGPG+GeWBVnlzniXj5/01iBpOGvWHRAm/tPBWrnG4KkU
 O8Xamg0+blouppzLydPwHy+2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 15:05:39 -0800
IronPort-SDR: 3PzSqr5Ig2yGSBjESAPHKIPdzwe+GjpbyncZAPqclw1kiexOLG6vWkZcKqf/VDxsqY4OAtj8tX
 Io5bJAUhaZRZ2uYmFLomlkVuDLRXp4J49scgIKh0C/+ExxOkRq0sWIfCmncK9gHRGXDDi+s1p/
 Jx8TSXYpAktJdv+/2Lvx6dKyrtAHTvtPT4U+jtXgXnY7E05SYamg2hDQ9AM/gY5yOmulbDBCYr
 aqCENGNJ3sCHaaWP6SRGIHkjdWCv3eM4UwhmhJE52WYtt2HxHaOe84PqJ/DBjCAHEHec3HN5Gg
 ZyA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 15:33:28 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JfzN66hqvz1SVp7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 15:33:26 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1642721606; x=1645313607; bh=bbAUjyI63AzHMI4JG4Nlo6/VnP4NtE6QUmV
        9m2+5F70=; b=nPviF7k6mge+zxBJQfoIVNdjwRcrV5QQ2EKWfvFapPCqzIiebTj
        D557Kwc0oLfiRItFOqHSP4Zkk7/qCv1CvQTNWI1IYa3djUfR7iYKe2Nkq0FOjg34
        UwZGYimrU5cnman+Y/6aNNVPiJYJ9AwN3hfGqdclwlIiV4r3uh4aRWAmai/7gFRL
        xrUYgC6HtPp9A5e/Ea/vLzdvzuhZ6hRg/maJm4hZxXM9aImrBFZFgXcsDWm276vc
        /b/K5e7dONGxO1zKn+DEMeQ8zyu+X4AhnG7lzQ/Ni2nLQuBiAKvIcQMGxlPsNnlg
        ehZDMSSHj3bGFwrUBohBrWaDKYIkEIDWuxA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RZGp9efpfP4x for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jan 2022 15:33:26 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JfzN440YFz1RvlN;
        Thu, 20 Jan 2022 15:33:24 -0800 (PST)
Message-ID: <b030d405-b687-581c-1694-a26da6c3a78a@opensource.wdc.com>
Date:   Fri, 21 Jan 2022 08:33:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH 12/12] RISC-V: defconfigs: Remove redundant K210 DT source
Content-Language: en-US
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        heinrich.schuchardt@canonical.com,
        Atish Patra <atishp@rivosinc.com>, bin.meng@windriver.com,
        sagar.kadam@sifive.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
References: <mhng-f042ecd2-dc39-4212-a2c6-3ea842c20e3c@palmer-ri-x1c9>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <mhng-f042ecd2-dc39-4212-a2c6-3ea842c20e3c@palmer-ri-x1c9>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/01/21 3:19, Palmer Dabbelt wrote:
> On Thu, 06 Jan 2022 18:14:00 PST (-0800), Damien.LeMoal@wdc.com wrote:
> 
> I just see an empty message here.  Not sure if it's something wrong with 
> my mail client, it's always a bit confused by yours -- it's usually not 
> this confused, but it is generally a broken mess so I wouldn't be 
> surprised by anything ;)

Sorry about that. I have some problems with my Thunderbird+Exquilla plugin on
the corporate MS Exchange account. Email replies are all sent empty since a
couple of weeks ago... Not sure what is going on but that is definitely on my
end. Switching gradually to this new email address (not MS Exchange :))

In this reply, I was simply saying "OK. Thanks !"

Cheers.

-- 
Damien Le Moal
Western Digital Research
