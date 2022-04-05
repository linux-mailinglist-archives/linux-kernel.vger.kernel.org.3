Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326054F4B5E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574377AbiDEWzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573239AbiDESbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 14:31:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C86713F6B;
        Tue,  5 Apr 2022 11:29:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0B7A618CE;
        Tue,  5 Apr 2022 18:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE7BC385A0;
        Tue,  5 Apr 2022 18:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649183341;
        bh=RipF2sDxCVo9q2EK1KCVAMcx4kdSJtLIqkmkUKxesng=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UDtQPEvYZ04ZzfdoEjWld2hT2TMhLGg0yXVXsBO/Ak7o4umpRfbxucC7Z99uXH7cW
         AjL4HQ8Cv2Q8/ii4mTu2moWoeSOc8jQbnGrub/IfxgaD11iFCrc7AQLER7gTOkSQXP
         chHYTnCdfoqzHBcMCd7WyVxJciFaqtrMjwLdUqwJyUkfm+FgY2nV4fTRxSE8O1BbHH
         4fqeSNDohq6f3/6vMQCIzJPzDiQn6HcWxLzP246GXjbwvh6iLdQIL8dcGsm/WXtVcq
         m+dhqLcYc3gy8QaSnDiahvft4KfubFEEGkGLbLeLaBFBtUhG7rTt95XU8mdHLynpFW
         yJ9r2pMNTlrxQ==
Message-ID: <13a43c8d9e9d103009e652e7e8ff49e6844316d5.camel@kernel.org>
Subject: Re: [PATCH RFC] x86/sgx: Simplify struct
 sgx_enclave_restrict_permissions
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        linux-sgx@vger.kernel.rog
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:INTEL SGX" <linux-sgx@vger.kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Date:   Tue, 05 Apr 2022 21:30:10 +0300
In-Reply-To: <76c6e673-71fb-1068-0114-c3eea93a2fd4@intel.com>
References: <20220405151642.96096-1-jarkko@kernel.org>
         <76c6e673-71fb-1068-0114-c3eea93a2fd4@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-05 at 10:21 -0700, Reinette Chatre wrote:
> Hi Jarkko,
>=20
> On 4/5/2022 8:16 AM, Jarkko Sakkinen wrote:
> > The reasoning to change SECINFO to simply flags is stated in this inlin=
e
> > comment:
> >=20
> > /*
> > =C2=A0* Return valid permission fields from a secinfo structure provide=
d by
> > =C2=A0* user space. The secinfo structure is required to only have bits=
 in
> > =C2=A0* the permission fields set.
> > =C2=A0*/
> >=20
> > It is better to simply change the parameter type than require to use
> > a malformed version of a data structure.
>=20
> Could you please elaborate what is malformed?

The structure that is accepted by the API. According to SDM permission
changes are done with a structure where PT_REG is set, which gives
-EINVAL. I categorize it as a bug.

BR, Jarkko
