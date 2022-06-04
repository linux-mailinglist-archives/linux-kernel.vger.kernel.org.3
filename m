Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A6C53D5DF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 08:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbiFDGw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 02:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiFDGwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 02:52:24 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6602F35268
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 23:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654325542; x=1685861542;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B0vd9IzMayeirFBr0uTktvimcBmNrFS3wz/9lNncGD0=;
  b=Fvzai2sHNGsVlmtZ16vLsYAtw/nRFZGmYPhVnrzmlx9pRSR/nCkboHug
   TH+Ziz4RjlbkZOOBo96A8GdeMb930Ck5CxQltYh8F4Y9JfddBcjqpjf2k
   mpLD0AY6G/uKheaq2vq8xOinA9AE/24EtxZBQRrnmOLzTFYKpTC69YVqW
   g7AexnJYwZePYPk8D437eI/C1sKFS94rnfGqLobYRSTz/0x70DCLqbf3+
   zqa3T07UO/t9MyHWgfbsdRmJP/qAw84zlYgla30y/SaXiIL4ThyUZ1NPL
   Y24bG+cfB+H3xBfPl+86Z+zATs/u3X3Y14snwIAW0fLgzZhZhTs/P1gZB
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10367"; a="362769833"
X-IronPort-AV: E=Sophos;i="5.91,276,1647327600"; 
   d="scan'208";a="362769833"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 23:52:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,276,1647327600"; 
   d="scan'208";a="607774921"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 03 Jun 2022 23:52:20 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxNdz-000ANo-Ii;
        Sat, 04 Jun 2022 06:52:19 +0000
Date:   Sat, 4 Jun 2022 14:52:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [kuba:tls-wip 25/27] net/tls/tls_sw.c:1952:6: warning: variable
 'rxm' is uninitialized when used here
Message-ID: <202206041430.w06wF78n-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git tls-wip
head:   38f7b843197f36fd1147d14d8dac84f0d480946d
commit: 03804ec62cc6126f981623a3d4afb3fa4eba64c7 [25/27] rxm - move updates into ctx
config: arm64-buildonly-randconfig-r002-20220531 (https://download.01.org/0day-ci/archive/20220604/202206041430.w06wF78n-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b364c76683f8ef241025a9556300778c07b590c2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git/commit/?id=03804ec62cc6126f981623a3d4afb3fa4eba64c7
        git remote add kuba https://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git
        git fetch --no-tags kuba tls-wip
        git checkout 03804ec62cc6126f981623a3d4afb3fa4eba64c7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash net/tls/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/tls/tls_sw.c:1952:6: warning: variable 'rxm' is uninitialized when used here [-Wuninitialized]
                                           rxm->offset = rxm->offset + rxm->full_len;
                                           ^~~
   net/tls/tls_sw.c:1944:24: note: initialize the variable 'rxm' to silence this warning
                           struct strp_msg *rxm;
                                               ^
                                                = NULL
   1 warning generated.


vim +/rxm +1952 net/tls/tls_sw.c

9655bea3d64350 Jakub Kicinski    2022-04-01  1815  
c46234ebb4d1ee Dave Watson       2018-03-22  1816  int tls_sw_recvmsg(struct sock *sk,
c46234ebb4d1ee Dave Watson       2018-03-22  1817  		   struct msghdr *msg,
c46234ebb4d1ee Dave Watson       2018-03-22  1818  		   size_t len,
c46234ebb4d1ee Dave Watson       2018-03-22  1819  		   int flags,
c46234ebb4d1ee Dave Watson       2018-03-22  1820  		   int *addr_len)
c46234ebb4d1ee Dave Watson       2018-03-22  1821  {
c46234ebb4d1ee Dave Watson       2018-03-22  1822  	struct tls_context *tls_ctx = tls_get_ctx(sk);
f66de3ee2c161f Boris Pismenny    2018-04-30  1823  	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
4509de14680084 Vakul Garg        2019-02-14  1824  	struct tls_prot_info *prot = &tls_ctx->prot_info;
d3b18ad31f93d0 John Fastabend    2018-10-13  1825  	struct sk_psock *psock;
692d7b5d1f9125 Vakul Garg        2019-01-16  1826  	unsigned char control = 0;
692d7b5d1f9125 Vakul Garg        2019-01-16  1827  	ssize_t decrypted = 0;
9655bea3d64350 Jakub Kicinski    2022-04-01  1828  	size_t flushed_at = 0;
c46234ebb4d1ee Dave Watson       2018-03-22  1829  	struct sk_buff *skb;
c46234ebb4d1ee Dave Watson       2018-03-22  1830  	ssize_t copied = 0;
7da18bcc5e4cfd Jakub Kicinski    2022-04-08  1831  	bool async = false;
06030dbaf3b6c5 Daniel Borkmann   2018-06-15  1832  	int target, err = 0;
c46234ebb4d1ee Dave Watson       2018-03-22  1833  	long timeo;
00e23707442a75 David Howells     2018-10-22  1834  	bool is_kvec = iov_iter_is_kvec(&msg->msg_iter);
692d7b5d1f9125 Vakul Garg        2019-01-16  1835  	bool is_peek = flags & MSG_PEEK;
e91de6afa81c10 John Fastabend    2020-05-29  1836  	bool bpf_strp_enabled;
ba13609df18dab Jakub Kicinski    2022-04-08  1837  	bool zc_capable;
c46234ebb4d1ee Dave Watson       2018-03-22  1838  
c46234ebb4d1ee Dave Watson       2018-03-22  1839  	if (unlikely(flags & MSG_ERRQUEUE))
c46234ebb4d1ee Dave Watson       2018-03-22  1840  		return sock_recv_errqueue(sk, msg, len, SOL_IP, IP_RECVERR);
c46234ebb4d1ee Dave Watson       2018-03-22  1841  
d3b18ad31f93d0 John Fastabend    2018-10-13  1842  	psock = sk_psock_get(sk);
c46234ebb4d1ee Dave Watson       2018-03-22  1843  	lock_sock(sk);
e91de6afa81c10 John Fastabend    2020-05-29  1844  	bpf_strp_enabled = sk_psock_strp_enabled(psock);
c46234ebb4d1ee Dave Watson       2018-03-22  1845  
f314bfee81b1bf Jakub Kicinski    2022-04-11  1846  	/* If crypto failed the connection is broken */
f314bfee81b1bf Jakub Kicinski    2022-04-11  1847  	err = ctx->async_wait.err;
f314bfee81b1bf Jakub Kicinski    2022-04-11  1848  	if (err)
f314bfee81b1bf Jakub Kicinski    2022-04-11  1849  		goto end;
f314bfee81b1bf Jakub Kicinski    2022-04-11  1850  
692d7b5d1f9125 Vakul Garg        2019-01-16  1851  	/* Process pending decrypted records. It must be non-zero-copy */
06554f4ffc2595 Jakub Kicinski    2022-04-08  1852  	err = process_rx_list(ctx, msg, &control, 0, len, false, is_peek);
4dcdd971b9c7a5 Jakub Kicinski    2022-04-11  1853  	if (err < 0)
692d7b5d1f9125 Vakul Garg        2019-01-16  1854  		goto end;
692d7b5d1f9125 Vakul Garg        2019-01-16  1855  
d5123edd10cf9d Jakub Kicinski    2022-04-07  1856  	copied = err;
46a1695960d060 Jakub Kicinski    2019-05-24  1857  	if (len <= copied)
bfc06e1aaa130b Jakub Kicinski    2022-04-07  1858  		goto end;
46a1695960d060 Jakub Kicinski    2019-05-24  1859  
06030dbaf3b6c5 Daniel Borkmann   2018-06-15  1860  	target = sock_rcvlowat(sk, flags & MSG_WAITALL, len);
46a1695960d060 Jakub Kicinski    2019-05-24  1861  	len = len - copied;
c46234ebb4d1ee Dave Watson       2018-03-22  1862  	timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
692d7b5d1f9125 Vakul Garg        2019-01-16  1863  
ba13609df18dab Jakub Kicinski    2022-04-08  1864  	zc_capable = !bpf_strp_enabled && !is_kvec && !is_peek &&
b814ee782eef62 Jakub Kicinski    2021-12-15  1865  		ctx->zc_capable;
bfc06e1aaa130b Jakub Kicinski    2022-04-07  1866  	decrypted = 0;
04b25a5411f966 Jakub Kicinski    2019-05-24  1867  	while (len && (decrypted + copied < target || ctx->recv_pkt)) {
a7026cf1297903 Jakub Kicinski    2022-05-26  1868  		struct tls_decrypt_arg darg;
9bdf75ccffa690 Jakub Kicinski    2022-04-08  1869  		int to_decrypt, chunk;
c46234ebb4d1ee Dave Watson       2018-03-22  1870  
a7026cf1297903 Jakub Kicinski    2022-05-26  1871  		memset(&darg.inargs, 0, sizeof(darg.inargs));
e3508236c701de Jakub Kicinski    2022-05-26  1872  		err = tls_wait_data(sk, psock, flags & MSG_DONTWAIT, timeo);
e3508236c701de Jakub Kicinski    2022-05-26  1873  		if (err <= 0) {
d3b18ad31f93d0 John Fastabend    2018-10-13  1874  			if (psock) {
0775639ce1ca95 Jakub Kicinski    2022-04-11  1875  				chunk = sk_msg_recvmsg(sk, psock, msg, len,
2bc793e3272a13 Cong Wang         2021-03-30  1876  						       flags);
257fd01208cd4c Jakub Kicinski    2022-05-25  1877  				if (chunk > 0) {
257fd01208cd4c Jakub Kicinski    2022-05-25  1878  					decrypted += chunk;
257fd01208cd4c Jakub Kicinski    2022-05-25  1879  					len -= chunk;
257fd01208cd4c Jakub Kicinski    2022-05-25  1880  					continue;
257fd01208cd4c Jakub Kicinski    2022-05-25  1881  				}
d3b18ad31f93d0 John Fastabend    2018-10-13  1882  			}
c46234ebb4d1ee Dave Watson       2018-03-22  1883  			goto recv_end;
d3b18ad31f93d0 John Fastabend    2018-10-13  1884  		}
c46234ebb4d1ee Dave Watson       2018-03-22  1885  
03804ec62cc612 Jakub Kicinski    2022-06-02  1886  		to_decrypt = ctx->full_len - prot->overhead_size;
fedf201e12960b Dave Watson       2019-01-30  1887  
06fa4c1bf464a9 Jakub Kicinski    2022-05-26  1888  		/* periodically flush backlog, and feed strparser */
06fa4c1bf464a9 Jakub Kicinski    2022-05-26  1889  		tls_read_flush_backlog(sk, prot, len, to_decrypt,
06fa4c1bf464a9 Jakub Kicinski    2022-05-26  1890  				       decrypted + copied, &flushed_at);
06fa4c1bf464a9 Jakub Kicinski    2022-05-26  1891  
ba13609df18dab Jakub Kicinski    2022-04-08  1892  		if (zc_capable && to_decrypt <= len &&
efb7d5ac289e35 Jakub Kicinski    2022-06-01  1893  		    ctx->control == TLS_RECORD_TYPE_DATA)
4175eac37123a6 Jakub Kicinski    2022-04-08  1894  			darg.zc = true;
fedf201e12960b Dave Watson       2019-01-30  1895  
c0ab4732d4c658 Vakul Garg        2019-02-11  1896  		/* Do not use async mode if record is non-data */
efb7d5ac289e35 Jakub Kicinski    2022-06-01  1897  		if (ctx->control == TLS_RECORD_TYPE_DATA && !bpf_strp_enabled)
4175eac37123a6 Jakub Kicinski    2022-04-08  1898  			darg.async = ctx->async_capable;
c0ab4732d4c658 Vakul Garg        2019-02-11  1899  		else
4175eac37123a6 Jakub Kicinski    2022-04-08  1900  			darg.async = false;
c0ab4732d4c658 Vakul Garg        2019-02-11  1901  
6e7221f5f493c2 Jakub Kicinski    2022-05-26  1902  		err = tls_decrypt_skb_update(sk, &msg->msg_iter, &darg);
3547a1f9d988d8 Jakub Kicinski    2022-04-11  1903  		if (err < 0) {
f34f8f7258594f Jakub Kicinski    2022-03-12  1904  			/* try to dodge memory failures */
f34f8f7258594f Jakub Kicinski    2022-03-12  1905  			if (err != -ENOMEM || !(decrypted + copied))
da353fac65fede Daniel Jordan     2021-10-27  1906  				tls_err_abort(sk, -EBADMSG);
fedf201e12960b Dave Watson       2019-01-30  1907  			goto recv_end;
fedf201e12960b Dave Watson       2019-01-30  1908  		}
fedf201e12960b Dave Watson       2019-01-30  1909  
a7026cf1297903 Jakub Kicinski    2022-05-26  1910  		skb = darg.skb;
6e7221f5f493c2 Jakub Kicinski    2022-05-26  1911  
3547a1f9d988d8 Jakub Kicinski    2022-04-11  1912  		async |= darg.async;
2b794c4098b525 Vakul Garg        2019-02-23  1913  
2b794c4098b525 Vakul Garg        2019-02-23  1914  		/* If the type of records being processed is not known yet,
2b794c4098b525 Vakul Garg        2019-02-23  1915  		 * set it to record type just dequeued. If it is already known,
2b794c4098b525 Vakul Garg        2019-02-23  1916  		 * but does not match the record type just dequeued, go to end.
2b794c4098b525 Vakul Garg        2019-02-23  1917  		 * We always get record type here since for tls1.2, record type
2b794c4098b525 Vakul Garg        2019-02-23  1918  		 * is known just after record is dequeued from stream parser.
2b794c4098b525 Vakul Garg        2019-02-23  1919  		 * For tls1.3, we disable async.
2b794c4098b525 Vakul Garg        2019-02-23  1920  		 */
efb7d5ac289e35 Jakub Kicinski    2022-06-01  1921  		err = tls_record_content_type(msg, ctx->control, &control);
06fa4c1bf464a9 Jakub Kicinski    2022-05-26  1922  		if (err <= 0) {
ee95a0f7b981ce Jakub Kicinski    2022-06-01  1923  			tls_rx_rec_stow_prepare(ctx, skb);
06fa4c1bf464a9 Jakub Kicinski    2022-05-26  1924  put_on_rx_list_err:
06fa4c1bf464a9 Jakub Kicinski    2022-05-26  1925  			__skb_queue_tail(&ctx->rx_list, skb);
c46234ebb4d1ee Dave Watson       2018-03-22  1926  			goto recv_end;
06fa4c1bf464a9 Jakub Kicinski    2022-05-26  1927  		}
b1a2c178633028 Jakub Kicinski    2022-04-08  1928  
9bdf75ccffa690 Jakub Kicinski    2022-04-08  1929  		if (async) {
9bdf75ccffa690 Jakub Kicinski    2022-04-08  1930  			/* TLS 1.2-only, to_decrypt must be text length */
9bdf75ccffa690 Jakub Kicinski    2022-04-08  1931  			chunk = min_t(int, to_decrypt, len);
ee95a0f7b981ce Jakub Kicinski    2022-06-01  1932  			tls_rx_rec_stow_prepare(ctx, skb);
257fd01208cd4c Jakub Kicinski    2022-05-25  1933  put_on_rx_list:
f940b6efb17257 Jakub Kicinski    2022-04-08  1934  			decrypted += chunk;
f940b6efb17257 Jakub Kicinski    2022-04-08  1935  			len -= chunk;
257fd01208cd4c Jakub Kicinski    2022-05-25  1936  			__skb_queue_tail(&ctx->rx_list, skb);
f940b6efb17257 Jakub Kicinski    2022-04-08  1937  			continue;
9bdf75ccffa690 Jakub Kicinski    2022-04-08  1938  		}
9bdf75ccffa690 Jakub Kicinski    2022-04-08  1939  		/* TLS 1.3 may have updated the length by more than overhead */
03804ec62cc612 Jakub Kicinski    2022-06-02  1940  		chunk = ctx->full_len;
c0ab4732d4c658 Vakul Garg        2019-02-11  1941  
4175eac37123a6 Jakub Kicinski    2022-04-08  1942  		if (!darg.zc) {
f940b6efb17257 Jakub Kicinski    2022-04-08  1943  			bool partially_consumed = chunk > len;
03804ec62cc612 Jakub Kicinski    2022-06-02  1944  			struct strp_msg *rxm;
f940b6efb17257 Jakub Kicinski    2022-04-08  1945  
ee95a0f7b981ce Jakub Kicinski    2022-06-01  1946  			tls_rx_rec_stow_prepare(ctx, skb);
ee95a0f7b981ce Jakub Kicinski    2022-06-01  1947  
e91de6afa81c10 John Fastabend    2020-05-29  1948  			if (bpf_strp_enabled) {
1c2133114d2d11 Jakub Kicinski    2022-05-18  1949  				/* BPF may try to queue the skb */
e91de6afa81c10 John Fastabend    2020-05-29  1950  				err = sk_psock_tls_strp_read(psock, skb);
e91de6afa81c10 John Fastabend    2020-05-29  1951  				if (err != __SK_PASS) {
e91de6afa81c10 John Fastabend    2020-05-29 @1952  					rxm->offset = rxm->offset + rxm->full_len;
e91de6afa81c10 John Fastabend    2020-05-29  1953  					rxm->full_len = 0;
e91de6afa81c10 John Fastabend    2020-05-29  1954  					if (err == __SK_DROP)
e91de6afa81c10 John Fastabend    2020-05-29  1955  						consume_skb(skb);
e91de6afa81c10 John Fastabend    2020-05-29  1956  					continue;
e91de6afa81c10 John Fastabend    2020-05-29  1957  				}
e91de6afa81c10 John Fastabend    2020-05-29  1958  			}
e91de6afa81c10 John Fastabend    2020-05-29  1959  
f940b6efb17257 Jakub Kicinski    2022-04-08  1960  			if (partially_consumed)
692d7b5d1f9125 Vakul Garg        2019-01-16  1961  				chunk = len;
94524d8fc965a7 Vakul Garg        2018-08-29  1962  
692d7b5d1f9125 Vakul Garg        2019-01-16  1963  			err = skb_copy_datagram_msg(skb, rxm->offset,
692d7b5d1f9125 Vakul Garg        2019-01-16  1964  						    msg, chunk);
06fa4c1bf464a9 Jakub Kicinski    2022-05-26  1965  			if (err < 0)
06fa4c1bf464a9 Jakub Kicinski    2022-05-26  1966  				goto put_on_rx_list_err;
692d7b5d1f9125 Vakul Garg        2019-01-16  1967  
f940b6efb17257 Jakub Kicinski    2022-04-08  1968  			if (is_peek)
257fd01208cd4c Jakub Kicinski    2022-05-25  1969  				goto put_on_rx_list;
f940b6efb17257 Jakub Kicinski    2022-04-08  1970  
f940b6efb17257 Jakub Kicinski    2022-04-08  1971  			if (partially_consumed) {
f940b6efb17257 Jakub Kicinski    2022-04-08  1972  				rxm->offset += chunk;
f940b6efb17257 Jakub Kicinski    2022-04-08  1973  				rxm->full_len -= chunk;
257fd01208cd4c Jakub Kicinski    2022-05-25  1974  				goto put_on_rx_list;
692d7b5d1f9125 Vakul Garg        2019-01-16  1975  			}
692d7b5d1f9125 Vakul Garg        2019-01-16  1976  		}
c46234ebb4d1ee Dave Watson       2018-03-22  1977  
692d7b5d1f9125 Vakul Garg        2019-01-16  1978  		decrypted += chunk;
c46234ebb4d1ee Dave Watson       2018-03-22  1979  		len -= chunk;
c46234ebb4d1ee Dave Watson       2018-03-22  1980  
465ea73535675e Jakub Kicinski    2022-04-08  1981  		consume_skb(skb);
465ea73535675e Jakub Kicinski    2022-04-08  1982  
f940b6efb17257 Jakub Kicinski    2022-04-08  1983  		/* Return full control message to userspace before trying
f940b6efb17257 Jakub Kicinski    2022-04-08  1984  		 * to parse another message type
c46234ebb4d1ee Dave Watson       2018-03-22  1985  		 */
c46234ebb4d1ee Dave Watson       2018-03-22  1986  		msg->msg_flags |= MSG_EOR;
3fe16edf6767de Vadim Fedorenko   2020-11-15  1987  		if (control != TLS_RECORD_TYPE_DATA)
f940b6efb17257 Jakub Kicinski    2022-04-08  1988  			break;
04b25a5411f966 Jakub Kicinski    2019-05-24  1989  	}
c46234ebb4d1ee Dave Watson       2018-03-22  1990  
c46234ebb4d1ee Dave Watson       2018-03-22  1991  recv_end:
7da18bcc5e4cfd Jakub Kicinski    2022-04-08  1992  	if (async) {
f314bfee81b1bf Jakub Kicinski    2022-04-11  1993  		int ret, pending;
7da18bcc5e4cfd Jakub Kicinski    2022-04-08  1994  
94524d8fc965a7 Vakul Garg        2018-08-29  1995  		/* Wait for all previously submitted records to be decrypted */
0cada33241d9de Vinay Kumar Yadav 2020-05-23  1996  		spin_lock_bh(&ctx->decrypt_compl_lock);
37943f047bfb88 Jakub Kicinski    2022-04-08  1997  		reinit_completion(&ctx->async_wait.completion);
0cada33241d9de Vinay Kumar Yadav 2020-05-23  1998  		pending = atomic_read(&ctx->decrypt_pending);
0cada33241d9de Vinay Kumar Yadav 2020-05-23  1999  		spin_unlock_bh(&ctx->decrypt_compl_lock);
0cada33241d9de Vinay Kumar Yadav 2020-05-23  2000  		if (pending) {
f314bfee81b1bf Jakub Kicinski    2022-04-11  2001  			ret = crypto_wait_req(-EINPROGRESS, &ctx->async_wait);
f314bfee81b1bf Jakub Kicinski    2022-04-11  2002  			if (ret) {
f314bfee81b1bf Jakub Kicinski    2022-04-11  2003  				if (err >= 0 || err == -EINPROGRESS)
f314bfee81b1bf Jakub Kicinski    2022-04-11  2004  					err = ret;
692d7b5d1f9125 Vakul Garg        2019-01-16  2005  				decrypted = 0;
692d7b5d1f9125 Vakul Garg        2019-01-16  2006  				goto end;
94524d8fc965a7 Vakul Garg        2018-08-29  2007  			}
94524d8fc965a7 Vakul Garg        2018-08-29  2008  		}
0cada33241d9de Vinay Kumar Yadav 2020-05-23  2009  
692d7b5d1f9125 Vakul Garg        2019-01-16  2010  		/* Drain records from the rx_list & copy if required */
692d7b5d1f9125 Vakul Garg        2019-01-16  2011  		if (is_peek || is_kvec)
06554f4ffc2595 Jakub Kicinski    2022-04-08  2012  			err = process_rx_list(ctx, msg, &control, copied,
692d7b5d1f9125 Vakul Garg        2019-01-16  2013  					      decrypted, false, is_peek);
692d7b5d1f9125 Vakul Garg        2019-01-16  2014  		else
06554f4ffc2595 Jakub Kicinski    2022-04-08  2015  			err = process_rx_list(ctx, msg, &control, 0,
692d7b5d1f9125 Vakul Garg        2019-01-16  2016  					      decrypted, true, is_peek);
4dcdd971b9c7a5 Jakub Kicinski    2022-04-11  2017  		decrypted = max(err, 0);
94524d8fc965a7 Vakul Garg        2018-08-29  2018  	}
94524d8fc965a7 Vakul Garg        2018-08-29  2019  
692d7b5d1f9125 Vakul Garg        2019-01-16  2020  	copied += decrypted;
692d7b5d1f9125 Vakul Garg        2019-01-16  2021  
692d7b5d1f9125 Vakul Garg        2019-01-16  2022  end:
c46234ebb4d1ee Dave Watson       2018-03-22  2023  	release_sock(sk);
d3b18ad31f93d0 John Fastabend    2018-10-13  2024  	if (psock)
d3b18ad31f93d0 John Fastabend    2018-10-13  2025  		sk_psock_put(sk, psock);
c46234ebb4d1ee Dave Watson       2018-03-22  2026  	return copied ? : err;
c46234ebb4d1ee Dave Watson       2018-03-22  2027  }
c46234ebb4d1ee Dave Watson       2018-03-22  2028  

:::::: The code at line 1952 was first introduced by commit
:::::: e91de6afa81c10e9f855c5695eb9a53168d96b73 bpf: Fix running sk_skb program types with ktls

:::::: TO: John Fastabend <john.fastabend@gmail.com>
:::::: CC: Alexei Starovoitov <ast@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
