Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA5A587586
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 04:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbiHBCVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 22:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiHBCVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 22:21:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928EC175AD;
        Mon,  1 Aug 2022 19:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659406879; x=1690942879;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=OZx7CajtvMkiCnlwt7rHIb0ADoHGq/IX7yj7nDLJgyE=;
  b=O6QuPqMFSMFQzoeZRhiHoa1C6K8s+atnXzl3Xs9PF3wt91PHd1A2zEKl
   ArG4b/vIhuRVVw5/AqyLXRQprK5iJa6gVorpo3LNHZudhVgPmZ+fzWRLz
   7K9tBilzt73vX3xHQVWVvr29Di9PzXZeWFcRuD/Tq6TbI7PsFv2yH0lIx
   84wPTGUbY42YEutGbJQOTaY3k39gPZFTOXtPn7zewLjDO6udZiJeZLTRL
   wop4buCOhvhrGHd9iR2ll+VzUj2qzm6++nbZ/n0/+gAcJAZOo1geVmw+5
   z0K8gRF9sCGABHaCXmyFJaYuUeE3o76TeEB5Dr9qBXyN+b91VyO8xF65t
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="289314369"
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="289314369"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 19:21:19 -0700
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="552747137"
Received: from vgutierr-mobl1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.212.22.230])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 19:21:16 -0700
Message-ID: <35d7254cafde24b722b167c6a3566592d903acd2.camel@intel.com>
Subject: Re: [PATCH] [v2] x86/sgx: Allow enclaves to use Asynchrounous Exit
 Notification
From:   Kai Huang <kai.huang@intel.com>
To:     Haitao Huang <haitao.huang@linux.intel.com>, dave@sr71.net,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 02 Aug 2022 14:21:13 +1200
In-Reply-To: <op.1p2k13ibwjvjmi@hhuan26-mobl1.mshome.net>
References: <20220720191347.1343986-1-dave.hansen@linux.intel.com>
         <op.1p2k13ibwjvjmi@hhuan26-mobl1.mshome.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> Tested-by: Haitao Huang <haitao.huang@intel.com>
>=20
> Thanks
> Haitao

Hi Haitao,

Could you also help to test in a VM?

You will also need below patch in order to use EDECCSSA in the guest:

https://lore.kernel.org/lkml/20220727115442.464380-1-kai.huang@intel.com/

When you create the VM, please use -cpu host.

--=20
Thanks,
-Kai


