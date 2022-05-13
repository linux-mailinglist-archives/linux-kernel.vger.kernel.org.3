Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09536525B7F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377304AbiEMG0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377305AbiEMG0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:26:20 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5E1289BD;
        Thu, 12 May 2022 23:26:07 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id A6A482013B0;
        Fri, 13 May 2022 06:26:05 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 03B6B80980; Fri, 13 May 2022 08:19:14 +0200 (CEST)
Date:   Fri, 13 May 2022 08:19:13 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Thomas Ristenpart <ristenpart@cornell.edu>,
        Yevgeniy Dodis <dodis@cs.nyu.edu>, tytso <tytso@mit.edu>,
        Nadia Heninger <nadiah@cs.ucsd.edu>,
        Noah Stephens-Dawidowitz <noahsd@gmail.com>,
        Stefano Tessaro <tessaro@cs.washington.edu>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "D. J. Bernstein" <djb@cr.yp.to>,
        "jeanphilippe.aumasson@gmail.com" <jeanphilippe.aumasson@gmail.com>,
        "jann@thejh.net" <jann@thejh.net>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Peter Schwabe <peter@cryptojedi.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: is "premature next" a real world rng concern, or just an
 academic exercise?
Message-ID: <Yn34YWhH1nSa8O8K@owl.dominikbrodowski.net>
References: <YmlMGx6+uigkGiZ0@zx2c4.com>
 <Ym3ZM1P+uYYABtRm@mit.edu>
 <Ym5sICj5iBMn2w/E@zx2c4.com>
 <CAMvzKsiA52Si=PzOJXYwGSA1WUz-1S0A8cpgRJWDzpMkfFbX+Q@mail.gmail.com>
 <CAMvzKsiMY_+8HZqeFqD3tR65a3-JB0LG=+0jBBy1zF4GanrsGA@mail.gmail.com>
 <7EB51D84-90A4-4C97-9A81-14A8C32990F7@cornell.edu>
 <YnzzuuLPssc3/tVe@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnzzuuLPssc3/tVe@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, May 12, 2022 at 01:47:06PM +0200 schrieb Jason A. Donenfeld:
> But on the other hand, it appears that none of us really thinks that
> premature next is a real problem worth complicating designs over. So
> maybe we can just say that it is nice when the silicon in one way or
> another helps with premature next, but maybe not an explicit must have.
> So where does that leave us?
> 
> - Systems with RDSEED/RDRAND don't have premature next, due to the above
>   KDF salt. This is probably the majority of systems out there these
>   days. This also applies to the sleep resumption notification (and the
>   vmgenid one), and I suspect that most systems with S3 or S0ix or
>   whatever else these days also probably have RDRAND.

... and most of these systems have TPM chips with a RNG, which is (alas)
usually only used at system startup, as that hw_rng device sets its quality
to 0 (meaning untrusted). So there's also room for improvement involving
these hw rng devices.

Thanks,
	Dominik
